import express from 'express';
import { authenticate } from '../../middlewares/Authenticate.js';
import { upload } from '../../middlewares/upload.js';
import { addpost,deletePost,getPosts  } from '../../controllers/club&Sports/postController.js';

const router = express.Router();

router.post('/addPost', authenticate, upload.single('image'), addpost);
router.delete('/deletePost/:id', authenticate, deletePost);
router.get('/getPosts/:id', authenticate, getPosts);

export default router;

