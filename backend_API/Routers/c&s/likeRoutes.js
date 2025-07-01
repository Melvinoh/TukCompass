import { authenticate } from "../../middlewares/Authenticate.js";
import express from "express";
import { likePost, getLikes, unlikePost } from "../../controllers/club&Sports/likesController.js";

const router = express.Router();

router.post("/:postID/likePost", authenticate, likePost);
router.delete("/:postID/unlikePost", authenticate, unlikePost);
router.get("/getLikes", authenticate, getLikes);

export default router;
