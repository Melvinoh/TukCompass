import express from "express"
import {uploadUnitPDF,uploadOfferingContent}from '../controllers/unitContentController.js'
import {upload} from "../middlewares/upload.js"


const router = express.Router()

router.post("/uploadPDF", upload.single('file'), uploadUnitPDF);
router.post("/uploadContent", uploadOfferingContent);

export default router