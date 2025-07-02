import express from 'express';
import { authenticate } from '../../middlewares/Authenticate.js';
import { addpost,deletePost,getPosts  } from '../../controllers/club&Sports/postController.js';


const router = express.Router();

router.post('/addPost', authenticate, addpost);
router.get('/deletePost', authenticate, deletePost);
router.delete('/getPosts', authenticate, getPosts);

export default router;
