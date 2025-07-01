import express from 'express';
import { addSchool } from '../../controllers/academics/schoolContoller.js';

const router = express.Router();

router.post('/addSchool', addSchool);


export default router;