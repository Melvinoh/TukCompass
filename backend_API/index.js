import express  from "express";
import "./modules/Relationship.js"

import registrationRoutes from "./Routers/registrationRoutes.js";
import classRoutes from "./Routers/classRoutes.js";
import courseRoutes from "./Routers/courseRoutes.js";
import schoolRoutes from "./Routers/schoolRoutes.js";
import facultyRoutes from "./Routers/facultyRoutes.js";
import departmentRoutes from "./Routers/departmentRoutes.js";
import adminRoutes from "./Routers/adminRoutes.js";
import unitEnrollmentRoutes from "./Routers/unitEnrollmentRoutes.js";
import unitOfferingRoutes from "./Routers/unitOfferingRoutes.js";
import curriculumRoutes from "./Routers/curriculumRoutes.js";



const app = express();

app.use(express.json());
app.use("/api/registration", registrationRoutes);
app.use("/api/class", classRoutes);
app.use("/api/course", courseRoutes);
app.use("/api/school", schoolRoutes);
app.use("/api/faculty", facultyRoutes);
app.use("/api/department", departmentRoutes);
app.use("/api/admin",curriculumRoutes)
app.use("/api/admin",adminRoutes)
app.use("/api/student",unitEnrollmentRoutes);
app.use("/api/lecturer",unitOfferingRoutes);


app.listen(3000, () => {
    console.log('Server running on port 3000');
});



