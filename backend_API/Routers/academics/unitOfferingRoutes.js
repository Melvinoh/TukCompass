import express from "express"
import{ unitOfferingReg, fetchCourses} from "../../controllers/academics/unitOfferingController.js"

const router = express.Router()

router.post('/offerUnit', unitOfferingReg)
router.post('/fetchCourses', fetchCourses)

export default router
