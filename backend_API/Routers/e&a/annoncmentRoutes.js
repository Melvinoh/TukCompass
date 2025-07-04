import express from 'express';
import { upload } from '../../middlewares/upload.js';
import { createAnnouncment, getAnnouncments, getAnnoncmentById, updateAnnouncment, deleteAnnouncment } from '../../controllers/e&a/annoncmentController.js';
import { authenticate } from '../../middlewares/Authenticate.js';

const router = express.Router();

router.post('/createAnnouncment', authenticate, upload.single('file'), createAnnouncment);
router.get('/getAnnouncments', getAnnouncments);
router.get('/getAnnouncmentById/:id', getAnnoncmentById);
router.patch('/updateAnnouncment/:id',authenticate, upload.single('file'), updateAnnouncment);
router.delete('/deleteAnnouncment/:id', deleteAnnouncment);

export default router;
