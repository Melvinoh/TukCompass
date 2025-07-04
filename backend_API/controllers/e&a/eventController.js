import { fileURLToPath } from "url";
import { cloudinary } from "../../config/cloudinary.js";
import { Events } from "../../modules/e&a/events.js";
import fs from "fs/promises";
import moment from "moment/moment.js";


export const createEvent = async (req, res) => {
    try {
        const { title, description, location, date, expireyDate, time, targetGroup} = req.body;
        const createdBy = req.user.userID;
        const createdAt =  moment(Date.now()).format("YYYY-MM-DD HH:mm:ss");

        if (!req.file) {
            return res.status(400).json({ message: "No file uploaded" });
        }
        const results = await cloudinary.uploader.upload(req.file.path, {
            folder: "events",
            resource_type: "auto",
            public_id: req.file.originalname
            .split(".")[0]
            .replace(/\s+/g, "_")
            .replace(/[^a-zA-Z0-9_-]/g, "")
        });

      await fs.unlink(req.file.path)

        const newEvent = await Events.create({
            title,
            description,
            location,
            date,
            expireyDate,
            time,
            targetGroup,
            fileUrl: results.secure_url,
            createdBy,
            createdAt
        });
        res.status(201).json({ 
            message: "Event created successfully",
            event: newEvent 
        });

    } catch (error) {
        console.error("Error creating event:", error);
        res.status(500).json({ 
            message: "Internal server error",
            error: error.message
        });
    }
}
export const getAllEvents = async (req, res) => {
    try {
        const events = await Events.findAll({
            order: [['createdAt', 'DESC']],
    
        });
        res.status(200).json({ 
            message: "Events retrieved successfully",
            events 
        });
    } catch (error) {
        console.error("Error retrieving events:", error);
        res.status(500).json({ 
            message: "Internal server error",
            error: error.message
        });
    }
}

export const getEventById = async (req, res) => {
    const { id } = req.params;
    try {
        const event = await Events.findOne({
            where: { eventID: id },
        });
        if (!event) {
            return res.status(404).json({ message: "Event not found" });
        }
        res.status(200).json({ 
            message: "Event retrieved successfully",
            event 
        });
    } catch (error) {
        console.error("Error retrieving event:", error);
        res.status(500).json({ 
            message: "Internal server error",
            error: error.message
        });
    }
}

export const deleteEvent = async (req, res) => {
    try {
        const { id } = req.params;

        const event = await Events.findOne({
            where: { eventID:id }
        });

        if (!event) {
            return res.status(404).json({ message: "event not found" });
        }

        await Events.destroy({
            where: { eventID:id  }
        });

        res.status(200).json({
            message: "event deleted successfully"
        });
    } catch (error) {
        console.error("Error deleting event:", error);
        res.status(500).json({
            message: "Internal server error",
            error: error.message
        });
    }
}


export const updateEvent = async (req, res) =>{

    console.log(req.body);
    const { title, description, location, date, expireyDate, time, targetGroup } = req.body;
    const { id } = req.params;
    const {userID} = req.user;

    try {

       let uploadedFileUrl = null;

        if (req.file?.path) {
            const fileUrl = await cloudinary.uploader.upload(req.file.path, {
                resource_type: "auto",
                folder: "events",
                public_id: req.file.originalname
                    .split(".")[0]
                    .replace(/\s+/g, "_")
                    .replace(/[^a-zA-Z0-9_-]/g, "")
            });
             uploadedFileUrl = fileUrl.secure_url;
             await fs.unlink(req.file.path)
        }
        

        const event = await Events.findOne({ where: { eventID : id } });

        if (!event) {
            return res.status(404).json({ message: "event not found" });
        }
        if(event.createdBy !== userID){
           return res.status(400).json({ message: "you can only update events you created" });
        }

        event.title = title || event.title;
        event.description = description || event.description;
        event.location = location || event.location;
        event.date = date || event.date;
        event.expireyDate = expireyDate || event.expireyDate;
        event.time = time || event.time;
        event.targetGroup = targetGroup || event.targetGroup;
        if (uploadedFileUrl) event.fileUrl = uploadedFileUrl;

        await event.save();

        res.status(200).json({ message: "event updated successfully", event });
    } catch (error) {
        console.error(error);
        res.status(500).json({ 
            message: "An error occurred while updating the event",
            error: error.message
        });
    }

}