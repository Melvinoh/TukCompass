import {ClubSports} from "./c&s.js"
import {User} from "../Users.js"
import {Likes} from "./likes.js"
import {Comments} from "./comments.js"
import {Connects} from "./connects.js"
import {CS_Members} from "./c&sMembers.js"
import {CS_Posts} from "./c&sPosts.js"
import {Posts} from "./post.js"



ClubSports.belongsToMany(User, { through: CS_Members, foreignKey: 'clubSportsID' })
User.belongsToMany(ClubSports, { through: CS_Members, foreignKey: 'userID' })

User.hasMany(Posts, { foreignKey: 'userID' })
Posts.belongsTo(User, { foreignKey: 'userID' })

Posts.hasMany(Likes, {foreignKey :'postID', onDelete:"CASCADE", hooks:true})
Likes.belongsTo(Posts, { foreignKey: 'postID' })

Posts.hasMany(Comments, {foreignKey :'postID', onDelete:"CASCADE", hooks:true})
Comments.belongsTo(Posts, { foreignKey: 'postID' })

User.hasMany(Likes, {foreignKey :'userID', onDelete:"CASCADE", hooks:true})
Likes.belongsTo(User, { foreignKey: 'userID' })

User.hasMany(Comments, {foreignKey :'userID', onDelete:"CASCADE", hooks:true})
Comments.belongsTo(Posts, { foreignKey: 'userID' })