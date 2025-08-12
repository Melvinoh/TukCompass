import express from "express"
import {addUnitConent,uploadOfferingContent,getUnitDetails,getUnitOfferingContent}from '../../controllers/academics/unitContentController.js'
import {upload} from "../../middlewares/upload.js"
import { authenticate } from '../../middlewares/Authenticate.js';


const router = express.Router()

router.post("/addUnitConent",authenticate, upload.single('file'), addUnitConent);
router.post("/uploadOfferingContent", authenticate,  upload.single('file'), uploadOfferingContent);
router.get("/getUnitDetails/:unitID", getUnitDetails);
router.get("/getUnitOfferingContent/:unitOfferingID", getUnitOfferingContent);

export default router