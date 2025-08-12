import express from "express";
import { getStudentsTimetable } from "../../controllers/academics/timetableController.js"; 
import { authenticate } from '../../middlewares/Authenticate.js';

const router = express.Router();

router.get("/studentTimetable",authenticate, getStudentsTimetable);

export default router;
    