import {Likes} from "../../modules/club&sport/likes.js";
import { Posts } from "../../modules/club&sport/post.js";


export const likePost = async (req, res) => {
  const {id} = req.params;
  const {userID} = req.user;
  try {
 
    const post = await Posts.findByPk(id);
    if (!post) {
      return res.status(404).json({ message: "Post not found" });
    }
    const existingLike = await Likes.findOne({ where: { postID: id, userID } });

    if (existingLike) {
      await existingLike.destroy();
      return res.status(200).json({ message: "Post unliked successfully" });
    }

    const newLike = await Likes.create({ postID: id, userID });

    return res.status(201).json({
      message: "Post liked successfully",
      like: newLike
    });

  } catch (error) {
    console.error("Error liking post:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
}

export const getLikes = async (req, res) => {
  const { id } = req.params;
  try {
    const likes = await Likes.findAll({
      where: { postID: id },
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
