import express  from "express";
import "./modules/Acdemics/Relationship.js";
import "./modules/club&sport/relationships.js"
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




const app = express();

app.use(express.json());
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

app.use("/api/clubSports",csRoutes);
app.use("/api/comments",commentRoutes);
app.use("/api/connects",connectRoutes);
app.use("/api/likes",likeRoutes);
app.use("/api/posts",postRoutes);

app.use("/api/events", eventRoutes);

app.listen(3000, () => {
    console.log('Server running on port 3000');
});



