import {cloudinary} from "../../config/cloudinary.js"
import fs from "fs/promises"
import moment from "moment/moment.js";
import {UnitContent} from "../../modules/Acdemics/unitContent.js"
import {UnitOfferingContent} from "../../modules/Acdemics/unitOfferingContent.js"
import { Unit } from "../../modules/Acdemics/units.js";
import { UnitOffering } from "../../modules/Acdemics/unitOffering.js";
import { Lecturer } from "../../modules/Acdemics/lecturers.js";
import { User } from "../../modules/Users.js";

export const addUnitConent = async (req,res)=>{

    const {unitID, description} =  req.body
    
    let courseOutline = ""

    const userID = req.user.userID;

    const uploadDate =  moment.utc().format("YYYY-MM-DD HH:mm:ss");

    console.log(req.file);
    if (!req.file) {
      return res.status(400).json({ message: "No file uploaded" });
    }
    
    if (req.file) {
      try {
        const result = await cloudinary.uploader.upload(req.file.path, {
          resource_type: "auto",
          folder: "files",
          public_id: req.file.originalname
            .split(".")[0]
            .replace(/\s+/g, "_")
            .replace(/[^a-zA-Z0-9_-]/g, "")
        });
        courseOutline = result.secure_url;
      } catch (err) {
        await t.rollback();
        return res.status(500).json({ message: "Image upload failed", error: err.message });
      }
    } 
    await fs.unlink(req.file.path)
    try {
      
        const newContent = await UnitContent.create({
            unitID,
            courseOutline,
            uploadDate,
            uploadedBy: userID,
            description
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

    let { unitOfferingID, link, contentType,fileName } = req.body
    const date = moment.utc().format("YYYY-MM-DD HH:mm:ss");

    let videoUrl= ""
    let PdfUrl = ""

    if(contentType === "video"){    
        videoUrl = link
        link = null
    }else if(contentType === "link"){
        videoUrl = null
    }else if(contentType === "pdf"){
        link = null
        videoUrl = null
    }else if(contentType == "assignment"){
        link = null
        videoUrl = null
    }else if(contentType == "past_papers"){
        link = null
        videoUrl = null
    }
    else{
        return res.status(400).json({
            message: "invalid content type"
        }) 
    }  


    if (contentType === "pdf" || contentType === "past_papers" || contentType === "assignment" ) {
      if (!req.file) {
        return res.status(400).json({ message: "No file uploaded" });
      }

      try {
        const result = await cloudinary.uploader.upload(req.file.path, {
          resource_type: "auto",
          folder: "files",
          public_id: req.file.originalname
            .split(".")[0]
            .replace(/\s+/g, "_")
            .replace(/[^a-zA-Z0-9_-]/g, ""),
        });

        PdfUrl = result.secure_url;
        await fs.unlink(req.file.path);

      } catch (err) {
        return res.status(500).json({
          message: "File upload failed",
          error: err.message,
        });
      }
    } 

  try {
      const newContent =  await UnitOfferingContent.create({
          unitOfferingID,
          videoUrl,
          link,
          contentType,
          uploadedAt: date,
          PdfUrl,
          fileName: fileName
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

export const getUnitDetails = async (req, res) => {
  const { unitID } = req.params;

  try {
    
    const unit = await Unit.findOne({
      where: { unitID },
      attributes: ["unitID", "unitName"],
    });

    if (!unit) {
      return res.status(404).json({ message: "Unit not found" });
    }

   
    const lecturers = await UnitOffering.findAll({
      where: { unitID },
      attributes: ["academicYear", "year", "sem", "unitOfferingID"],
      include: [
        {
          model: Lecturer,
          attributes: ["lecturerID"],
          include: [
            {
              model: User,
              attributes: ["fname", "sname", "profileUrl"],
            },
          ],
        },
      ],
    });
   
    const formattedLecturers = lecturers.map((offer) => {
      const lecturer = offer.lecturers_tb;
      console.log(lecturer);
      const user = lecturer.user_tb;
      return {
        fullName: `${user.fname} ${user.sname}`,
        profileUrl: user.profileUrl,
        academicYear: offer.academicYear,
        year: offer.year,
        sem: offer.sem,
        unitOfferingID: offer.unitOfferingID,
      };
    });

    
    const unitContent = await UnitContent.findOne({
      where: { unitID },
      attributes: ["courseOutline", "description", "uploadDate"],
      include: [
        {
          model: User,
          attributes: ["fname", "sname"],
        },
      ],
    });

    const courseOutline = unitContent
      ? {
          courseOutline: unitContent.courseOutline,
          description: unitContent.description,
          uploadedBy: unitContent.user_tb
            ? `${unitContent.user_tb.fname} ${unitContent.user_tb.sname}`
            : null,
          uploadDate: unitContent.uploadDate,
        }
      : null;

    const pastPapers = await UnitOfferingContent.findAll({
      include: [
        {
          model: UnitOffering,
          where: { unitID },
          attributes: [],
        },
      ],
      where: {
        contentType: "past_papers",
      },
      attributes: ["PdfUrl", "fileName", "uploadedAt"],
    });

    return res.status(200).json({
      unit,
      lecturers: formattedLecturers,
      courseOutline,
      pastPapers,
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: "Server error", error: err.message });
  }
};



export const getUnitOfferingContent = async (req, res) => {
  const { unitOfferingID } = req.params;

  try {
    const contents = await UnitOfferingContent.findAll({
      where: { unitOfferingID },
      attributes: ["offeringContentID", "contentType", "PdfUrl", "videoUrl", "link", "fileName", "uploadedAt"],
      order: [['uploadedAt', 'DESC']],
    });

    const grouped = {
      pdf: [],
      assignment: [],
      video: [],
      link: [],
      past_papers: [],
    };

    contents.forEach((content) => {
      const item = {
        id: content.offeringContentID,
        title: content.fileName,
        uploadedAt: content.uploadedAt,
        url: content.PdfUrl || content.videoUrl || content.link || null,
        contentType: content.contentType,
      };

      if (grouped[content.contentType]) {
        grouped[content.contentType].push(item);
      }
    });

    return res.status(200).json({
      content: grouped,
    });

  } catch (err) {
    console.error(err);
    return res.status(500).json({
      message: "Failed to fetch content",
      error: err.message,
    });
  }
};

