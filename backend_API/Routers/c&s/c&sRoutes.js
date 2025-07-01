import express from "express"
import {creatClubSport,getClubSport,getClubSportID} from "../../controllers/club&Sports/c&sController.js"
import { upload } from "../../middlewares/upload.js";
import { get } from "http";


const router = express.Router()

router.post(
    '/createClubSport',
    upload.fields([
        {name: 'profile', maxCount: 1},
        {name: 'cover', maxCount: 1}
    ]),
    creatClubSport
);
router.get('/getClubSport',getClubSport);
router.get('/getClubSport/:id',getClubSportID);

export default router;