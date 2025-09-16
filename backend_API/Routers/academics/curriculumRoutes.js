import express from "express";
import {addCurriculum,fetchUserCourseUnits} from "../../controllers/academics/curriculumController.js";
import { authenticate } from "../../middlewares/Authenticate.js";

const router = express.Router();

router.post('/unitsRegistration', addCurriculum);
router.get('/fetchUnits', authenticate, fetchUserCourseUnits);

export default router; 