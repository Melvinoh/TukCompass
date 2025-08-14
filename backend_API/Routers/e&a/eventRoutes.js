import express from "express";
import { Events } from "../../modules/e&a/events.js";
import { createEvent, getAllEvents, getEventById,updateEvent,deleteEvent } from "../../controllers/e&a/eventController.js";
import { upload } from '../../middlewares/upload.js';
import { authenticate } from '../../middlewares/Authenticate.js'


const router = express.Router();

router.post("/createEvent", authenticate, upload.single("image"), createEvent);
router.get("/getEvents", getAllEvents);
router.get("/getEvents/:id", getEventById);
router.patch('/updateEvent/:id', authenticate, upload.single("file"), updateEvent);
router.delete('/deleteEvent/:id', deleteEvent);

export default router;
