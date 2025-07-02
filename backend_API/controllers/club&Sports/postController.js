import { Posts } from "../../modules/club&sport/post.js";
import { sequelize } from "../../config/sequelizeDB.js";
import { CS_Posts } from "../../modules/club&sport/c&sPosts.js";
import { User } from "../../modules/Users.js";
import moment from "moment/moment.js";
import { cloudinary } from "../../config/cloudinary.js";

export const addpost = async (req, res) => {
  const { description, clubSportID } = req.body;
  const userID = req.user.userID;
  const date =  moment(Date.now()).format("YYYY-MM-DD HH:mm:ss");

    let imageURL= null;
    if (req.file) {
    const result = await cloudinary.uploader.upload(req.file.path, {
        resource_type: "image",
        folder: "posts",
        public_id: req.file.originalname
        .split(".")[0]
        .replace(/\s+/g, "_")
        .replace(/[^a-zA-Z0-9_-]/g, "")
    });
    imageURL = result.secure_url;
    }

  const t = await sequelize.transaction();
  try {
    const newPost = await Posts.create({
      description,
      imageURL,
      date,
      userID
    }, { transaction: t });

    const newCSPost = await CS_Posts.create({
      clubSportID,
      postID: newPost.postID
    }, { transaction: t });

    await t.commit();

    return res.status(201).json({
      message: "Post created successfully",
      post: newPost,
      csPost: newCSPost
    });

  } catch (error) {
    console.error("Error creating post:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};
export const getPosts = async (req, res) => {
  const clubSportID = req.params.clubSportID;
  try {
    const posts = await CS_Posts.findAll({
      where: { clubSportID },
      include: [{
        model: Posts,
        as: 'post',
        include: [{
          model: User,
          as: 'user'
        }]
      }]
    });

    if (posts.length === 0) {
      return res.status(404).json({ message: "No posts found for this club/sport" });
    }
    return res.status(200).json(posts);

  } catch (error) {
    console.error("Error fetching posts:", error);
    return res.status(500).json({
         message: "Internal server error",
         error: error.message
    });
  }
}
export const deletePost = async (req, res) => {
  const postID = req.params.postID;
  try {
    const post = await Posts.findByPk(postID);
    if (!post) {
      return res.status(404).json({ message: "Post not found" });
    }

    await post.destroy();
    return res.status(200).json({ message: "Post deleted successfully" });

  } catch (error) {
    console.error("Error deleting post:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
}