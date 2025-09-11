import express  from "express";
import { Server } from "socket.io";
import http from "http";
import {attachSocketIO} from "./middlewares/socket.js"

import "./modules/Acdemics/Relationship.js";
import "./modules/club&sport/relationships.js"
import "./modules/chats/chatRelationships.js";
import "./modules/e&a/indexR.js"


import registrationRoutes from "./Routers/academics/registrationRoutes.js";
import classRoutes from "./Routers/academics/classRoutes.js";
import courseRoutes from "./Routers/academics/courseRoutes.js";
import schoolRoutes from "./Routers/academics/schoolRoutes.js";
import facultyRoutes from "./Routers/academics/facultyRoutes.js";
import departmentRoutes from "./Routers/academics/departmentRoutes.js";
import adminRoutes from "./Routers/academics/adminRoutes.js";
import unitEnrollmentRoutes from "./Routers/academics/unitEnrollmentRoutes.js";
import unitOfferingRoutes from "./Routers/academics/unitOfferingRoutes.js";
import curriculumRoutes from "./Routers/academics/curriculumRoutes.js";
import unitContentRoutes from "./Routers/academics/unitContentRoutes.js";

import csRoutes from "./Routers/c&s/c&sRoutes.js";
import commentRoutes from "./Routers/c&s/commentRoutes.js";
import connectRoutes from "./Routers/c&s/connectRoutes.js";
import likeRoutes from "./Routers/c&s/likeRoutes.js";
import postRoutes from "./Routers/c&s/postRoutes.js";
import authRoutes from "./Routers/authenticationRouter.js";

import eventRoutes from "./Routers/e&a/eventRoutes.js"
import annoncmentRoutes from "./Routers/e&a/annoncmentRoutes.js"
import timetableRoutes from "./Routers/academics/timetableRoutes.js"; 

import chatRoutes from "./Routers/chatRoutes/chatRoutes.js"

const app = express();
const server = http.createServer(app);
const io = new Server(server)

export const onlineUsers = new Map()

app.use(express.json());

const welcome = (req, res) => {
  res.send("Welcome to TukCompass API");
};


app.use(attachSocketIO(io));

io.use((socket, next) => {
  const token = socket.handshake.auth?.token || socket.handshake.query?.token;
  if (!token) return next(new Error('Authentication error'));
  try {
    const payload = jwt.verify(token, process.env.JWT_SECRET || 'dev_secret');
    socket.user = payload; 
    next();
  } catch (e) {
    next(new Error('Authentication error'));
  }
});

io.on("connection", async (socket) => {
    console.log("✅ User connected: " + socket.id);

    const userID = string(socket.user.userID)

    if(!onlineUsers.has(userID)) onlineUsers.set(userID, new Set())
      onlineUsers.get(userID).add(socket.id)

    socket.join(`user: ${userID}`)

    socket.on("joinChat", (chatID) => {
      socket.join(chatID);
      console.log(`User joined chat: ${chatID}`);
    });

    try {
      const myChats = await ChatMember.findAll(
        {
          where : {userID: socket.user.userID},
          attributes : ['chatID']
        }
      )
      myChats.forEach( chat => socket.join(`chat:${m.chatID}`))
    } catch (err) {
      
      console.error("failed to join chat rooms" , err)
      
    }

  

    socket.on("disconnect", () => {
        console.log("❌ User disconnected: " + socket.id);
    });
});

export const broadcastOnline = (io) =>{
  const online = Array.from(onlineUsers.keys())
  io.emit('online_Users', {online})
}

app.get("/", welcome);
app.use("/api/chat", chatRoutes);
app.use("/api/registration", registrationRoutes);
app.use("/api/auth", authRoutes);
app.use("/api/class", classRoutes);
app.use("/api/course", courseRoutes);
app.use("/api/school", schoolRoutes);
app.use("/api/faculty", facultyRoutes);
app.use("/api/department", departmentRoutes);
app.use("/api/admin",curriculumRoutes)
app.use("/api/admin",adminRoutes)
app.use("/api/student",unitEnrollmentRoutes);
app.use("/api/lecturer",unitOfferingRoutes);
app.use("/api/unitContent",unitContentRoutes);
app.use("/api/timetable", timetableRoutes);

app.use("/api/clubSports",csRoutes);
app.use("/api/comments",commentRoutes);
app.use("/api/connects",connectRoutes);
app.use("/api/likes",likeRoutes);
app.use("/api/posts",postRoutes);

app.use("/api/events", eventRoutes);
app.use("/api/announcment", annoncmentRoutes);

app.use("/api/chats", chatRoutes);



server.listen(3000,"0.0.0.0", () => {
    console.log('Server running on port 3000');
});
