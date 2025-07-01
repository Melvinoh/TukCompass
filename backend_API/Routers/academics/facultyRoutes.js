import express from 'express';
import { addFaculty } from '../../controllers/academics/facultyController.js';

const router = express.Router();

router.post('/addFaculty', addFaculty);

export default router;
