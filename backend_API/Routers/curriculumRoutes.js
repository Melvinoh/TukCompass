import express from "express";
import {addCurriculum} from "../controllers/curriculumController.js";

const router = express.Router();

router.post('/unitsRegistration', addCurriculum);

export default router; 