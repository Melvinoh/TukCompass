import express from 'express'
import {followUser,unfollowUser,getFollowers,getFollowing} from "../../controllers/club&Sports/connectsController.js"
import { authenticate } from '../../middlewares/Authenticate.js'

const router = express.Router()


router.post('/addConnect', authenticate, followUser)
router.delete('/removeConnect', authenticate, unfollowUser)
router.get('/following', authenticate, getFollowing)
router.get('/followers', authenticate, getFollowers)

export default router
