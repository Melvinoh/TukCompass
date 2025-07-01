import express from "express"
import {userRegistration} from "../../controllers/academics/registrationController.js"


const router = express.Router()

router.post("/signup", userRegistration);


export default router