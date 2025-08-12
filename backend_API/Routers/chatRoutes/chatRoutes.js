import express from "express"
import { getUserChats,sendMessage,getChatMessages} from "../../controllers/chatModule/chatController.js"
import { authenticate } from "../../middlewares/Authenticate.js";
import { upload } from "../../middlewares/upload.js";

const router = express.Router();


router.post("/sendMessage", authenticate, upload.single("file"), sendMessage);
router.get("/getUserChats", authenticate, getUserChats);
router.get("/getChatMessages/:chatID", authenticate, getChatMessages);


export default router;
