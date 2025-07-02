import { authenticate } from "../../middlewares/Authenticate.js";
import express from "express";
import { likePost, getLikes} from "../../controllers/club&Sports/likesController.js";

const router = express.Router();

router.post("/likePost/:id", authenticate, likePost);
router.get("/getLikes/:id", authenticate, getLikes);

export default router;
