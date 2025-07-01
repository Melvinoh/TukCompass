import express from 'express';
import { authenticate } from '../../middlewares/Authenticate.js';
import { addComment, deleteComment, getComments } from '../../controllers/club&Sports/commentsController.js';

const router = express.Router();

router.post("/:postID/addComments", authenticate, addComment);
router.delete("/:postID/comments/:commentID", authenticate, deleteComment);
router.get("/:postID/comments", authenticate, getComments);

export default router;
