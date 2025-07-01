import express from 'express';
import { addDepartment } from '../../controllers/academics/departmentContoller.js';

const router = express.Router();

router.post('/addDepartment', addDepartment);

export default router;
// This code defines an Express router for handling department-related routes.
