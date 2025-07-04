import { Announcments} from "../../modules/e&a/announcment.js";
import moment from "moment/moment.js";
import { cloudinary } from "../../config/cloudinary.js";
import fs from "fs/promises";

export const createAnnouncment = async (req, res) => {
    try {
        let schoolID  = ""
        const { title, message, targetGroup} = req.body;
        const createdBy = req.user.userID;
        const createdAt = moment(Date.now()).format("YYYY-MM-DD HH:mm:ss");

        schoolID = req.body.schoolID;

        if (!req.file) {
            return res.status(400).json({ message: "No file uploaded" });
        }

        const results = await cloudinary.uploader.upload(req.file.path, {
            folder: "annoncments",
            resource_type: "auto",
            public_id: req.file.originalname
                .split(".")[0]
                .replace(/\s+/g, "_")
                .replace(/[^a-zA-Z0-9_-]/g, "")
        });

        await fs.unlink(req.file.path);

        const newAnnouncment = await Announcments.create({
            title,
            message,
            fileUrl: results.secure_url,
            targetGroup,
            schoolID,
            createdBy,
            createdAt
        });

        res.status(201).json({
            message: "Announcment created successfully",
            announcement: newAnnouncment
        });

    } catch (error) {
        console.error("Error creating announcement:", error);
        res.status(500).json({
            message: "Internal server error",
            error: error.message
        });
    }
}

export const getAnnouncments = async (req, res) => {
    try {
        const announcments = await Announcments.findAll({
            order: [["createdAt", "DESC"]]
        });

        res.status(200).json({
            message: "Announcments retrieved successfully",
            announcments
        });
    } catch (error) {
        console.error("Error retrieving announcments:", error);
        res.status(500).json({
            message: "Internal server error",
            error: error.message
        });
    }
}

export const getAnnoncmentById = async (req, res) => {
    try {
        const { id } = req.params;

        const announcment = await Announcments.findOne({
            where: { announcmentID: id }
        });

        if (!announcment) {
            return res.status(404).json({ message: "Announcment not found" });
        }

        res.status(200).json({
            message: "Announcment retrieved successfully",
            announcment
        });
    } catch (error) {
        console.error("Error retrieving announcment:", error);
        res.status(500).json({
            message: "Internal server error",
            error: error.message
        });
    }
}

export const deleteAnnouncment = async (req, res) => {
    try {
        const { id } = req.params;

        const announcment = await Announcments.findOne({
            where: { announcmentID:id }
        });

        if (!announcment) {
            return res.status(404).json({ message: "Announcment not found" });
        }

        await Announcments.destroy({
            where: { announcmentID:id  }
        });

        res.status(200).json({
            message: "Announcment deleted successfully"
        });
    } catch (error) {
        console.error("Error deleting announcment:", error);
        res.status(500).json({
            message: "Internal server error",
            error: error.message
        });
    }
}

export const updateAnnouncment = async (req, res) => {
    try {
        const { id } = req.params;
        const { title, message, targetGroup } = req.body;

        const announcment = await Announcments.findOne({
            where: { announcmentID:id  }
        });

        if (!announcment) {
            return res.status(404).json({ message: "Announcment not found" });
        }

        if (req.file) {
            const results = await cloudinary.uploader.upload(req.file.path, {
                folder: "annoncments",
                resource_type: "auto",
                public_id: req.file.originalname
                    .split(".")[0]
                    .replace(/\s+/g, "_")
                    .replace(/[^a-zA-Z0-9_-]/g, "")
            });

            await fs.unlink(req.file.path);
            announcment.fileUrl = results.secure_url;
        }

        announcment.title = title || announcment.title;
        announcment.message = message || announcment.message;
        announcment.targetGroup = targetGroup || announcment.targetGroup;

        await announcment.save();

        res.status(200).json({
            message: "Announcment updated successfully",
            announcment
        });
    } catch (error) {
        console.error("Error updating announcment:", error);
        res.status(500).json({
            message: "Internal server error",
            error: error.message
        });
    }
}