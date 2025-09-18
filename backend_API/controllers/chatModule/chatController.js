import { ChatMember } from "../../modules/chats/chatMembers.js";
import { Chats } from "../../modules/chats/chats.js";
import { ChatMessage } from "../../modules/chats/messages.js";
import { cloudinary } from "../../config/cloudinary.js";
import { User } from "../../modules/Users.js";

async function createChat(senderID, receiverID, type, chatName, chatAvatar) {

  let chat = null;

  if (type === "private" && senderID && receiverID) {
 
    const userChats = await ChatMember.findAll({
      where: { userID: senderID }
    });

    const chatIDs = userChats.map(c => c.chatID);

    const chatsWithBoth = await ChatMember.findOne({
      where: {
        chatID: chatIDs,
        userID: receiverID
      },
      include: [{
        model: Chats,
        attributes: ["chatID"],
        where: { type: type }
      }]
    });

    if(chatsWithBoth){
      chat = chatsWithBoth;

    }

    if (!chat) {
      const transaction = await Chats.sequelize.transaction();

      try {
        const newChat = await Chats.create({ 
            type: type,
            chatName: type == "group" ? chatName : null,
            chatAvatar: type == "group" ? chatAvatar : null,
        },{transaction});

        const membersToAdd = [
          { chatID: newChat.chatID, userID: senderID },
          { chatID: newChat.chatID, userID: receiverID },
        ];

        await ChatMember.bulkCreate(membersToAdd,{transaction});
        await transaction.commit();

        chat = newChat;
       
      } catch (error) {

        await transaction.rollback();
        console.error("Error creating chat:", error);
      }
    }
  }
  return chat;

};

export const sendMessage = async (req, res) => {
  try {
    const { receiverID, type, message, chatName, chatAvatar } = req.body;

    console.log("Request body:", req.body);
    const senderID = req.user.userID; 

    const file = req.file;
    const chat = await createChat(senderID, receiverID, type, chatName, chatAvatar);


    if (!chat) {
      return res.status(404).json({ message: "Chat not found or could not be created" });
    }
    

    let mediaUrl = null;
    let mediaType = "none";

   
    if (file) {

      mediaType = getMediaType(file.originalname);

      const uploaded = await cloudinary.uploader.upload(file.path, {
        resource_type: mediaType === "video" ? "video" : "auto",
        folder: "chat_media",
        public_id: req.file.originalname
            .split(".")[0]
            .replace(/\s+/g, "_")
            .replace(/[^a-zA-Z0-9_-]/g, "")
      });

      mediaUrl = uploaded.secure_url;
    }

    const newMessage = await ChatMessage.create({

      chatID: chat.chatID,
      messageContent: message,
      mediaUrl,
      senderID,

    });

    const userDet = await User.findOne({
      where: { userID: senderID },
      attributes: ["userID", "fname", "sname", "profileUrl"]
    });

    newMessage.dataValues.senderName = `${userDet.fname} ${userDet.sname}`;
    newMessage.dataValues.profileUrl = userDet.profileUrl;
   
    const lastSeen = await ChatMember.update(
      { lastSeen: new Date() },
      { where: { chatID: chat.chatID, userID: senderID } }
  
    );

 const payload = { newMessage };

  console.log("📤 Emitting to room:", chat.chatID);
  console.log("📦 Payload type:", typeof payload, payload);
  console.log("📦 JSON payload:", JSON.stringify(payload, null, 2));

  req.io.to(chat.chatID).emit("new_message", payload);


    res.status(201).json({
      message: "Message sent successfully",
      data: newMessage ,
      lastSeen: lastSeen
    });

  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error sending message", error: err.message });
  }
};


export const getUserChats = async (req, res) => {

  const userID = req.user.userID;

  try {
  
  const chats = await Chats.findAll({
    include: [
      {
        model: ChatMember,
        as: "ChatMembers",        // ✅ second include: full members
        attributes: ["memberID", "userID", "lastSeen"],
        include: [
            { model: User, attributes: ["userID", "fname", "sname", "profileUrl"] }
        ]
      },
      {
        model: ChatMember,
        as: "UserMembership",
        required: "true",
        where:{userID},
        attributes: [],
      },

    ],
    order: [["updatedAt", "DESC"]]

  });
 
  const interim = await Promise.all(chats.map(async (chat) => {
    
    const lastMessage = await ChatMessage.findOne({
      where: { chatID: chat.chatID },
      order: [["createdAt", "DESC"]],
      limit: 1
    });
  
    const recievers = chat.ChatMembers.find(m => m.userID !== userID)
    let receiverName = chat.chatName || "";
    let profileurl = chat.chatAvatar || "";
    let receiverID = "";

    if (!chat.isGroupChat) {
      if (recievers) {
        
        receiverName = `${recievers.user_tb.fname} ${recievers.user_tb.sname}`;
        profileurl = recievers.user_tb.profileUrl || "";
        receiverID = recievers.user_tb.userID || "";
      }
    }
    let receiverLastSeen = null;
    return {
      chatID: chat.chatID,
      profileUrl: profileurl || "",
      receiverName: receiverName || "",
      receiverID: receiverID || "",
      lastSeen: receiverLastSeen ? new Date(receiverLastSeen).toISOString() : null,
      message: lastMessage ? lastMessage.messageContent : "",
      __lastMessageTime: lastMessage ? new Date(lastMessage.createdAt).getTime() : (chat.updatedAt ? new Date(chat.updatedAt).getTime() : 0)
    };
  }));

  interim.sort((a, b) => b.__lastMessageTime - a.__lastMessageTime);

 
  const payload = interim.map(({ __lastMessageTime, ...rest }) => rest);

  return res.json({ 
    message: "Chats retrieved successfully",
    chats: interim
  });

  } catch (err) {
  console.error(err);
  return res.status(500).json({ success: false, message: err.message });
  }
};

export const getChatMessages = async (req, res) => {
  try {
    const { chatID } = req.params;
    const userID = req.user.userID; // from auth middleware

    const membership = await ChatMember.findOne({
      where: { chatID, userID }
    });

    if (!membership) {
      return res.status(403).json({ success: false, message: "Access denied" });
    }

    const messages = await ChatMessage.findAll({
      where: { chatID },
      include: [
        {
          model: User,
          attributes: ["userID", "fname", "sname", "profileUrl"]
        }
      ],
      order: [["createdAt", "ASC"]] // oldest first
    });
    
    // Build payload
    const formattedMessages = messages.map(msg => ({
      chatID: msg.chatID,
      messageID: msg.messageID,
      messageContent: msg.messageContent,
      mediaUrl: msg.mediaUrl,
      senderID: msg.senderID,
      profileUrl: msg.user_tb.profileUrl,
      senderName: `${msg.user_tb.fname} ${msg.user_tb.sname}`,
      createdAt: msg.createdAt
    }));

    res.json({
      response: "Messages retrieved successfully",
      chatID: chatID,
      messages: formattedMessages
    });

  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: "Server error" });
  }
};
function getMediaType(filename) {
  if (!filename) return "file";

  const ext = filename.split('.').pop().toLowerCase();

  const imageExts = ["jpg", "jpeg", "png", "gif", "bmp", "webp"];
  const videoExts = ["mp4", "mov", "avi", "mkv", "webm", "flv"];
  const docExts = ["pdf", "doc", "docx", "xls", "xlsx", "ppt", "pptx", "txt"];

  if (imageExts.includes(ext)) return "image";
  if (videoExts.includes(ext)) return "video";
  if (docExts.includes(ext)) return "document";

  return "file"; // default fallback
}

