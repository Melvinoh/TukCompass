import express from "express"
import{ unitOfferingReg} from "../controllers/unitOfferingController.js"

const router = express.Router()

router.post('/offerUnit', unitOfferingReg)

export default router