import { ClubSports } from "../../modules/club&sport/c&s.js";
import { cloudinary } from "../../config/cloudinary.js";
import { CS_Members } from "../../modules/club&sport/c&sMembers.js";
import { User } from "../../modules/Users.js";
import { CS_Posts } from "../../modules/club&sport/c&sPosts.js";
import { Posts } from "../../modules/club&sport/post.js";

export const creatClubSport = async (req, res) => {
  try {
    const { clubSportsID, name, type, description, patron } = req.body;

    let profileUrl = null;
    let coverUrl = null;

    if (req.files?.profile?.[0]) {
      const result = await cloudinary.uploader.upload(req.files.profile[0].path, {
        resource_type: "image",
        folder: "TukCompass",
        public_id: req.files.profile[0].originalname
          .split(".")[0]
          .replace(/\s+/g, "_")
          .replace(/[^a-zA-Z0-9_-]/g, "")
      });
      profileUrl = result.secure_url;
    }

    if (req.files?.cover?.[0]) {
      const result2 = await cloudinary.uploader.upload(req.files.cover[0].path, {
        resource_type: "image",
        folder: "TukCompass",
        public_id: req.files.cover[0].originalname
          .split(".")[0]
          .replace(/\s+/g, "_")
          .replace(/[^a-zA-Z0-9_-]/g, "")
      });
      coverUrl = result2.secure_url;
    }

    const newClubSport = await ClubSports.create({
      clubSportsID,
      name,
      type,
      profileURL: profileUrl,
      coverURL: coverUrl,
      description,
      patron
    });

    res.status(200).json({
      message: "Created successfully",
      clubSport: newClubSport
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: "Could not create club or sport",
      error: error.message
    });
  }
};

export const getClubSport = async (req,res) => {
  
  const {type} = req.body

  try {
    
    const response = await ClubSports.findAll({
      where:{
        type: type
      }
    })

    if (response.length === 0) {
      return res.status(404).json({
        message: "No clubs found"
      });
    }
    
    res.status(200).json({
      message:'fetch successful',
      clubSport: response
    });

  } catch (error) {

    console.error(error)
    res.status(500).json({
      message: "could not fetch data an error occured",
      err: error.message
    })
  }
}
export const getClubSportID = async (req,res) => {
  const {id} = req.params;
  try {
    const response = await ClubSports.findOne({
      where: {
        clubSportsID: id
      }
    });

    if (!response) {
      return res.status(404).json({
        message: "Club or sport not found"
      });
    }

    res.status(200).json({
      message: "Fetch successful",
      clubSport: response
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: "Could not fetch data, an error occurred",
      err: error.message
    });
  }
}

export const updateClubSport = async (req, res) => {
  const { id } = req.params;
  const updates = req.body; 

  try {
    let profileUrl = null;
    let coverUrl = null;

    if (req.files?.profile?.[0]) {
      const result = await cloudinary.uploader.upload(req.files.profile[0].path, {
        resource_type: "image",
        folder: "TukCompass",
        public_id: req.files.profile[0].originalname
          .split(".")[0]
          .replace(/\s+/g, "_")
          .replace(/[^a-zA-Z0-9_-]/g, "")
      });
      profileUrl = result.secure_url;
    }

    if (req.files?.cover?.[0]) {
      const result2 = await cloudinary.uploader.upload(req.files.cover[0].path, {
        resource_type: "image",
        folder: "TukCompass",
        public_id: req.files.cover[0].originalname
          .split(".")[0]
          .replace(/\s+/g, "_")
          .replace(/[^a-zA-Z0-9_-]/g, "")
      });
      coverUrl = result2.secure_url;
    }

    const updateData = {
      ...(updates.name && { name: updates.name }),
      ...(profileUrl && { profileURL: profileUrl }),
      ...(coverUrl && { coverURL: coverUrl }), 
      ...(updates.description && { description: updates.description })     
    };

    const response = await ClubSports.update(updateData, {
      where: { clubSportID: id }
    });

    if (!response[0]) {
      return res.status(404).json({
        message: "Club or sport not found"
      });
    }
    res.status(200).json({
      message: "Update successful",
      clubSport: {
        ...updateData
      }
    });

  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: "Could not update club or sport",
      error: error.message
    });
  }
};


export const enrollClubSport = async (req, res) => {
  const {id} = req.params;
  const userID = req.user.userID;

  try {
    const existingEnrollment = await CS_Members.findOne({ where: { userID, clubSportID: id } });
    if (existingEnrollment) {
      return res.status(400).json({ message:"member"});
    }
// Enroll the user
    await CS_Members.create({ userID, clubSportID: id });
    return res.status(200).json({ message: "Enrolled successfully" });

  } catch (error) {
    console.error("Error enrolling in club/sport:", error);
    return res.status(500).json({ 
      message: "Internal server error",
      error: error.message
     });
  }
}
export const getMembers = async (req, res) => {
  const {id} = req.params;
  console.log(id);
  try {
    const members = await CS_Members.findAll({
      where: {clubSportID: id},
      attributes: ['userID', 'clubSportID'],
      include: [{
        model: User,
        as: 'user',
        attributes: ['profileUrl', 'fname','sname'],
      }]
    });

    if (members.length === 0) {
      return res.status(404).json({ message: "No members found for this club/sport" });
    }
    return res.status(200).json(members);

  } catch (error) {
    console.error("Error fetching members:", error);
    return res.status(500).json({
      message: "Internal server error",
      error: error.message
    });
  }
}

export const getGallery = async (req, res) => {
  const {id} = req.params;
  try {
    const gallery = await CS_Posts.findAll({
      where: {
         clubSportID: id
      },
      include: [{
        model: Posts,
        attributes: ['imageURL'],
        as: 'post'
      }]
    });
    res.status(200).json(gallery.map(item => item.post.imageURL));
  } catch (error) {
    console.error("Error fetching gallery:", error);
    return res.status(500).json({
      message: "Internal server error",
      error: error.message
    });
  }
}
