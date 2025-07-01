import express from "express"
import {adminPanel} from "../../controllers/academics/adminController.js"

const router = express.Router()

router.post("/registration",adminPanel)

export default router