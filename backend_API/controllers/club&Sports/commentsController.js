
import { User } from "../../modules/Users.js";
import { Comments } from "../../modules/club&sport/comments.js";
import { sequelize } from "../../config/sequelizeDB.js"

export const addComment = async (req, res) => {
  const { description, postID } = req.body;
  const userID = req.user.userID;
  const t = await sequelize.transaction();
  try {
    const newComment = await Comments.create({
      description,
      postID,
      userID
    }, { transaction: t });

    await t.commit();

    return res.status(201).json({
      message: "Comment added successfully",
      comment: newComment
    });

  } catch (error) {
    console.error("Error adding comment:", error);
    await t.rollback();
    return res.status(500).json({ message: "Internal server error" });
  }
}

export const getComments = async (req, res) => {
  const {postID} = req.body;
  try {
    const comments = await Comments.findAll({
      where: { postID },
      attributes: ['commentID', 'description'],
      include: [{
        model: User,
        attributes: ['fname', 'sname', 'profileUrl', 'userID']
      }]
    });

    if (comments.length === 0) {
      return res.status(404).json({ message: "No comments found for this post" });
    }
    return res.status(200).json(comments);

  } catch (error) {
    console.error("Error fetching comments:", error);
    return res.status(500).json({
      message: "Internal server error",
      error: error.message
    });
  }
}
export const deleteComment = async (req, res) => {
  const {id}= req.params;
  const userID = req.user.userID;

  try {
    const comment = await Comments.findOne({ where: { commentID: id, userID } });

    if (!comment) {
      return res.status(404).json({ message: "Comment not found or you do not have permission to delete it" });
    }

    await comment.destroy();

    return res.status(200).json({ message: "Comment deleted successfully" });

  } catch (error) {
    console.error("Error deleting comment:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
}


