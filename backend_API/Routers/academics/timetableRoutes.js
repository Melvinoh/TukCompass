import express from "express";
import { getStudentsTimetable,getLecturerTimetable } from "../../controllers/academics/timetableController.js"; 
import { authenticate } from '../../middlewares/Authenticate.js';

const router = express.Router();

router.get("/studentTimetable",authenticate, getStudentsTimetable);
router.get("/lecturerTimetable",authenticate, getLecturerTimetable);

export default router;
    