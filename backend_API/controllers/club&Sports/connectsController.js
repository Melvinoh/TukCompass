import { Connects } from "../../modules/club&sport/connects.js"
import { User } from "../../modules/Users.js"


export const followUser = async (req, res) => {
  try {
    const followerID = req.user.userID     
    const { followingID } = req.body       

    if (followerID === followingID) {
      return res.status(400).json({ message: "You cannot follow yourself." })
    }
    const existing = await Connects.findOne({
      where: { followerID, followingID }
    })

    if (existing) {
      return res.status(409).json({ message: "Already following this user." })
    }

    const connection = await Connects.create({ followerID, followingID })

    res.status(201).json({ message: "Followed successfully", connection })
  } catch (err) {
    console.error("Follow error:", err)
    res.status(500).json({ message: "Internal server error" })
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
    const followerID = req.user.userID

    const following = await Connects.findAll({
      where: { followerID },
      include: [{
        model: User,
        as: 'followingUser', 
        attributes: ['userID', 'name', 'email']
      }]
    })

    res.status(200).json(following)
  } catch (err) {
    res.status(500).json({ message: "Failed to fetch following list", error: err.message })
  }
}


export const getFollowers = async (req, res) => {
  try {
    const followingID = req.user.userID

    const followers = await Connects.findAll({
      where: { followingID },
      include: [{
        model: User,
        as: 'followerUser', 
        attributes: ['userID', 'name', 'email']
      }]
    })

    res.status(200).json(followers)
  } catch (err) {
    res.status(500).json({ message: "Failed to fetch followers", error: err.message })
  }
}
