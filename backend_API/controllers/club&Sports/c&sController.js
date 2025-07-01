import { ClubSports } from "../../modules/club&sport/c&s.js";
import { cloudinary } from "../../config/cloudinary.js";

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
        type: 'clubs'
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

  const {clubSportsID} = req.params;

  try {
    const response = await ClubSports.findOne({
      where: {
        clubSportsID
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
    const { profileUrl, coverUrl, name, description } = req.body;
    const { clubSportsID } = req.params;
    try {
      let updatedProfileUrl = profileUrl;
      let updatedCoverUrl = coverUrl;

      if (req.files?.profile?.[0]) {
        const result = await cloudinary.uploader.upload(req.files.profile[0].path, {
          resource_type: "image",
          folder: "TukCompass",
          public_id: req.files.profile[0].originalname
            .split(".")[0]
            .replace(/\s+/g, "_")
            .replace(/[^a-zA-Z0-9_-]/g, "")
        });
        updatedProfileUrl = result.secure_url;
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
        updatedCoverUrl = result2.secure_url;
      }

      const response = await ClubSports.update(
        {
          profileURL: updatedProfileUrl,
          coverURL: updatedCoverUrl,
          name,
          description
        },
        {
          where: {
            clubSportsID: clubSportsID
          }
        }
      );

      if (!response[0]) {
        return res.status(404).json({
          message: "Club or sport not found"
        });
      }

      res.status(200).json({
        message: "Update successful",
        clubSport: {
          profileURL: updatedProfileUrl,
          coverURL: updatedCoverUrl,
          name,
          description
        }
      });
    } catch (error) {
      console.error(error);
      res.status(500).json({
        message: "Could not update club or sport",
        error: error.message
      });
      
    }
}
