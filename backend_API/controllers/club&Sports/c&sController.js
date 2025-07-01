import { ClubSports } from "../../modules/club&sport/c&s.js";
import { sequelize } from "../../config/sequelizeDB.js";
import { cloudinary } from "../../config/cloudinary.js";

// Assumes you're using upload.fields([{name: 'profile'}, {name: 'cover'}])
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
