import express from "express"
import {creatClubSport,enrollClubSport,getClubSport,getClubSportID, getMembers,getGallery,updateClubSport,myclubs} from "../../controllers/club&Sports/c&sController.js"
import { upload } from "../../middlewares/upload.js";
import { authenticate } from "../../middlewares/Authenticate.js";


const router = express.Router()

router.post(
    '/createClubSport',
    upload.fields([
        {name: 'profile', maxCount: 1},
        {name: 'cover', maxCount: 1}
    ]),
    creatClubSport
);
router.get('/getClubSport' ,authenticate, getClubSport);
router.patch('/updateClubSport/:id',updateClubSport);
router.post('/enrollClubSport', authenticate, enrollClubSport);
router.get('/getClubSport/:id',getClubSportID);
router.get('/getMembers/:id',getMembers);
router.get('/getGallery/:id',getGallery);
router.get('/getMyClubs', authenticate, myclubs);

export default router;