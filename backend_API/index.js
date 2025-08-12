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


app.use(express.json());

const welcome = (req, res) => {
  res.send("Welcome to TukCompass API");
};


app.use(attachSocketIO(io));



io.on("connection", (socket) => {
    console.log("✅ User connected: " + socket.id);

    socket.on("joinChat", (chatID) => {
      socket.join(chatID);
      console.log(`User joined chat: ${chatID}`);
    });

    socket.on("message", (data) => {
        const { chatID, message } = data;
        io.to(chatID).emit("receiveMessage", message);
        console.log(`Message sent to chat ${chatID}: ${message}`);
    });

    socket.on("disconnect", () => {
        console.log("❌ User disconnected: " + socket.id);
    });
});

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
