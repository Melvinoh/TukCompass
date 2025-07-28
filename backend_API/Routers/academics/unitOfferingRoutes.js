import express from "express"
import{ unitOfferingReg, getUnitOffering} from "../../controllers/academics/unitOfferingController.js"
import { authenticate } from "../../middlewares/Authenticate.js";


const router = express.Router()

router.post('/offerUnit', unitOfferingReg)
router.get('/getOffering',authenticate, getUnitOffering)

export default router