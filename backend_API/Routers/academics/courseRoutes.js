import express from 'express';
import { addCourse } from '../../controllers/academics/courseController.js';

const router = express.Router();

router.post('/addCourse', addCourse);

export default router;
