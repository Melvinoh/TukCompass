import express from 'express';
import { authenticate } from '../../middlewares/Authenticate.js';
import { addpost,deletePost,getPosts  } from '../../controllers/club&Sports/postController.js';


const router = express.Router();

router.use('/addPost', authenticate, addpost);
router.use('/deletePost', authenticate, deletePost);
router.use('/getPosts', authenticate, getPosts);

export default router;
