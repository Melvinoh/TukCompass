import express from "express"
import {adminPanel} from "../controllers/adminController.js"

const router = express.Router()

router.post("/registration",adminPanel)

export default router