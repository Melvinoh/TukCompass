import { Connects } from "../../modules/club&sport/connects.js"
import { User } from "../../modules/Users.js"


export const followUser = async (req, res) => {
  try {
    const { userID } = req.user
    const { followingID } = req.body

    if (userID === followingID) {
      return res.status(400).json({ 
        message: "You cannot follow yourself.",
       })
    }
    const existing = await Connects.findOne({
      where: { followingID, followerID: userID },
      attributes: ['connectID']
    })
    if (existing) {
      await existing.destroy()
      return res.status(200).json({ 
        message: "Unfollowed successfully",
        connection: existing
       })
    }

    const connection = await Connects.create({ followingID, followerID: userID })

    res.status(201).json({ message: "Followed successfully", connection })
  } catch (err) {
    console.error("Follow error:", err)
    res.status(500).json({ 
      message: "Internal server error",
      error: err.message
     })
  }
}


export const unfollowUser = async (req, res) => {
  try {
    const followerID = req.user.userID
    const { followingID } = req.body

    const unfollow = await Connects.destroy({
      where: { followerID, followingID }
    })

    if (unfollow === 0) {
      return res.status(404).json({ message: "Not following this user" })
    }

    res.status(200).json({ message: "Unfollowed successfully" })
  } catch (err) {
    res.status(500).json({ message: "Failed to unfollow", error: err.message })
  }
}

export const getFollowing = async (req, res) => {
  try {
    const { userID } = req.user

    const following = await Connects.findAll({
      where: { followerID: userID },
      attributes: ['connectID', 'followerID'],
      include: [{
        model: User,
        as: 'followingUser',
        attributes: ['userID', 'fname', 'sname', 'profileUrl']
      }]
    });
    res.status(200).json({
      following: following,
      count: following.length   
    })

  } catch (err) {
    res.status(500).json({ message: "Failed to fetch following list", error: err.message })
  }
}


export const getFollowers = async (req, res) => {
  try {
    const { userID } = req.user

    const followers = await Connects.findAll({
      where: { followingID: userID },
      include: [{
        model: User,
        as: 'followerUser', 
        attributes: ['userID', 'fname', 'sname', 'profileUrl']
      }]
    });

    res.status(200).json({
      followers: followers,
      count: followers.length
    })
  } catch (err) {
    res.status(500).json({ message: "Failed to fetch followers", error: err.message })
  }
}
