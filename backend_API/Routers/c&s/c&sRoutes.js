import express from "express"
import {creatClubSport} from "../../controllers/club&Sports/c&sController.js"
import { upload } from "../../middlewares/upload.js";


const router = express.Router()

router.post(
    '/createClubSport',
    upload.fields([
        {name: 'profile', maxCount: 1},
        {name: 'cover', maxCount: 1}
    ]),
    creatClubSport
);


export default router;