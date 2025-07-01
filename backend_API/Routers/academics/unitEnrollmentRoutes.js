import express from "express"
import{enrollStudentInUnit} from "../../controllers/academics/unitEnrollmentController.js"

const router = express.Router()

router.post('/enrollUnit', enrollStudentInUnit)

export default router