import {Likes} from "../../modules/club&sport/likes.js";
import { Posts } from "../../modules/club&sport/post.js";


export const likePost = async (req, res) => {
  const postID = req.params.postID;
  const userID = req.user.userID;

  try {
 
    const post = await Posts.findByPk(postID);
    if (!post) {
      return res.status(404).json({ message: "Post not found" });
    }

    const existingLike = await Likes.findOne({ where: { postID, userID } });
    if (existingLike) {
      return res.status(400).json({ message: "You have already liked this post" });
    }
    const newLike = await Likes.create({ postID, userID });

    return res.status(201).json({
      message: "Post liked successfully",
      like: newLike
    });

  } catch (error) {
    console.error("Error liking post:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
}


export const unlikePost = async (req, res) => {
  const postID = req.params.postID;
  const userID = req.user.userID;

  try {
    // Check if the like exists
    const like = await Likes.findOne({ where: { postID, userID } });
    if (!like) {
      return res.status(404).json({ message: "Like not found" });
    }

    // Delete the like
    await like.destroy();

    return res.status(200).json({ message: "Post unliked successfully" });

  } catch (error) {
    console.error("Error unliking post:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
}

export const getLikes = async (req, res) => {
  const postID = req.params.postID;
  try {
    const likes = await Likes.findAll({
      where: { postID },
    });

    if (likes.length === 0) {
      return res.status(404).json({ message: "No likes found for this post" });
    }
    return res.status(200).json(likes.length);

  } catch (error) {
    console.error("Error fetching likes:", error);
    return res.status(500).json({
      message: "Internal server error",
      error: error.message
    });
  }
}
