import express from 'express';
import { addFaculty } from '../controllers/facultyController.js';

const router = express.Router();

router.post('/addFaculty', addFaculty);

export default router;
