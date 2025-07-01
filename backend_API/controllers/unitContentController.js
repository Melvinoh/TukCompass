import {UnitContent} from "../modules/unitContent.js"
import {UnitOfferingContent} from "../modules/unitOfferingContent.js"
import {cloudinary} from "../config/cloudinary.js"
import fs from "fs/promises"


export const uploadUnitPDF = async (req,res)=>{

    const {unitID, fileName, uploadedBy,} =  req.body

    try {

        console.log(req.file);

        if(!req.file){
            res.status(400).json({
                message:"no file uploaded"
            })
        }
        const publicID = req.file.originalname
            .split('.')[0]
            .replace(/\s+/g, '_')
            .replace(/[^a-zA-Z0-9_-]/g, '');

        const result = await cloudinary.uploader.upload(req.file.path,{
            resource_type: 'raw',
            folder: 'unit_pdfs',
            public_id: publicID
        })

        await fs.unlink(req.file.path)

        const newContent = await UnitContent.create({
            unitID,
            pdfURL: result.secure_url,
            fileName,
            uploadedBy
        })
        res.status(201).json({
            message: "file uploaded succefully",
            content : newContent
        })

    } catch (error) {

        console.error(error)
        res.status(500).json({
            message: "could not upload pdf",
            error: error.message
        })
        
    }
}

export const uploadOfferingContent = async (req,res) =>{

    const{ unitOfferingID, link, type } = req.body

    try {

        let result = null
        let videoURL= null

        if(req.file){
            const videoURL = await cloudinary.uploader.upload(req.file.path, {
                resource_type: 'mp3',
                folder: 'Recordings',
                public_id: req.file.originalname.split('.')[0]
            })
        }
        const newContent =  await UnitOfferingContent.create({
            unitOfferingID,
            videoURL: videoURL.secure_url,
            link,
            type,
            description
        })
        res.status(201).json({
            message: "upload succefull",
            content: newContent
        })

    } catch (error) {

        console.error(error);
        res.status(500).json({
        message: "upload failed, please try again!",
        error : error.message
        })

    }
}