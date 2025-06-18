import express from 'express';
import { addClass } from '../controllers/classContoller.js';

const router = express.Router();

router.post('/addClass', addClass);

export default router;