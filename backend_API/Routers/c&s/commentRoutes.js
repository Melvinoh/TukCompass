import express from 'express';
import { authenticate } from '../../middlewares/Authenticate.js';
import { addComment, deleteComment, getComments } from '../../controllers/club&Sports/commentsController.js';

const router = express.Router();

router.post("/addComments", authenticate, addComment);
router.delete("/deleteComment/:id", authenticate, deleteComment);
router.get("/getComments", authenticate, getComments);


export default router;
