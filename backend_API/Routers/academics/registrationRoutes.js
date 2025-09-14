import express from "express"
import {userRegistration, updateUser, getContacts} from "../../controllers/academics/registrationController.js"
import { upload } from "../../middlewares/upload.js";
import { authenticate } from "../../middlewares/Authenticate.js";


const router = express.Router()

router.post("/signup", userRegistration);
router.patch("/updateUser", upload.single("file"), authenticate, updateUser);
router.get("/getContacts", authenticate, getContacts);


export default router