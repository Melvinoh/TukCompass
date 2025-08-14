import express from "express"
import{enrollStudentInUnit,getEnrolledUnits} from "../../controllers/academics/unitEnrollmentController.js"
import { authenticate } from "../../middlewares/Authenticate.js";

const router = express.Router()

router.post('/enrollUnit', enrollStudentInUnit)
router.get('/getEnrollednits',authenticate, getEnrolledUnits)


export default router