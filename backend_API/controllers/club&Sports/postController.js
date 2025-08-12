import { Posts } from "../../modules/club&sport/post.js";
import { sequelize } from "../../config/sequelizeDB.js";
import { CS_Posts } from "../../modules/club&sport/c&sPosts.js";
import { User } from "../../modules/Users.js";
import moment from "moment/moment.js";
import { cloudinary } from "../../config/cloudinary.js";
import { CS_Members } from "../../modules/club&sport/c&sMembers.js";

export const addpost = async (req, res) => {
  try {

    const { description, clubID } = req.body;
    const userID = req.user.userID;
    const date = moment.utc().format("YYYY-MM-DD HH:mm:ss");

    const t = await sequelize.transaction();

    const user = await CS_Members.findOne({
      where: { userID, clubSportID: clubID },
      transaction: t
    });

    if (!user) {
      await t.rollback();
      return res.status(404).json({ message: "You are not a member of this club. Kindly enroll." });
    }

    let imageURL = null;
    if (req.file) {
      try {
        const result = await cloudinary.uploader.upload(req.file.path, {
          resource_type: "image",
          folder: "posts",
          public_id: req.file.originalname
            .split(".")[0]
            .replace(/\s+/g, "_")
            .replace(/[^a-zA-Z0-9_-]/g, "")
        });
        imageURL = result.secure_url;
      } catch (err) {
        await t.rollback();
        return res.status(500).json({ message: "Image upload failed", error: err.message });
      }
    }

    const newPost = await Posts.create({
      description,
      imageURL,
      date,
      userID
    }, { transaction: t });

    const newCSPost = await CS_Posts.create({
      clubSportID: clubID,
      postID: newPost.postID
    }, { transaction: t });

    await t.commit();

    return res.status(201).json({
      message: "Post created successfully",
      post: newPost,
    });

  } catch (error) {
    console.error("Error creating post:", error);
    return res.status(500).json({
      message: "Internal server error",
      error: error.message
    });
  }
};


export const getPosts = async (req, res) => {
  const {id} = req.params;
  try {
    const posts = await CS_Posts.findAll({
      where: { clubSportID: id },
      attributes: ['postID', 'clubSportID'],
      include: [{
        model: Posts,
        attributes: ['description', 'imageURL', 'date'],
        include: [{
          model: User,
          attributes: ['fname','sname', 'profileUrl', 'userID'],
        }]
      }]
    });
    if (posts.length === 0) {
      return res.status(404).json({ message: "No posts found for this club/sport" });
    }
  return res.status(200).json({
    posts
  });

  } catch (error) {
    console.error("Error fetching posts:", error);
    return res.status(500).json({
      message: "Internal server error",
      error: error.message
    });
  }
}
export const deletePost = async (req, res) => {
  const { id } = req.params;
  const userID = req.user.userID;
  try {
    const post = await Posts.findByPk(id);
    if (!post && post.userID !== userID) {
      return res.status(404).json({ message: "can not delete post" });
    }

    await post.destroy();
    return res.status(200).json({ message: "Post deleted successfully" });

  } catch (error) {
    console.error("Error deleting post:", error);
    return res.status(500).json({ 
      message: "Internal server error",
      error: error.message
    });
  }
}