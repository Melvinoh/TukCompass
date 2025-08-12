import {Chats} from "./chats.js"
import {ChatMember} from "./chatMembers.js"
import {ChatMessage} from "./messages.js";
import { User } from "../Users.js";


Chats.hasMany(ChatMember, {foreignKey: "chatID",sourceKey: "chatID", as: "ChatMembers"});
ChatMember.belongsTo(Chats, {foreignKey: "chatID", targetKey: "chatID", onDelete: "CASCADE",onUpdate: "CASCADE"});

User.hasMany(ChatMember, {foreignKey: "userID",sourceKey: "userID",});
ChatMember.belongsTo(User, {foreignKey: "userID", targetKey: "userID", onDelete: "CASCADE",onUpdate: "CASCADE"});

Chats.hasMany(ChatMessage, {foreignKey: "chatID", sourceKey: "chatID"});
ChatMessage.belongsTo(Chats, {foreignKey: "chatID", targetKey: "chatID" , onDelete: "CASCADE", onUpdate: "CASCADE"});

ChatMessage.belongsTo(User, {foreignKey: "senderID", targetKey: "userID",onDelete: "CASCADE", onUpdate: "CASCADE"});
User.hasMany(ChatMessage, {foreignKey: "senderID", targetKey: "userID"});


    