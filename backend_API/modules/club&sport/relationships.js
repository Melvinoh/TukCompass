import {ClubSports} from "./c&s.js"
import {User} from "../Users.js"
import {Likes} from "./likes.js"
import {Comments} from "./comments.js"
import {Connects} from "./connects.js"
import {CS_Members} from "./c&sMembers.js"
import {CS_Posts} from "./c&sPosts.js"
import {Posts} from "./post.js"



ClubSports.belongsToMany(User, { through: CS_Members, foreignKey: 'clubSportID', otherKey: 'userID' })
User.belongsToMany(ClubSports, { through: CS_Members, foreignKey: 'userID', otherKey: 'clubSportID' })

CS_Members.belongsTo(User, { foreignKey: 'userID', as: 'user' });
User.hasMany(CS_Members, { foreignKey: 'userID' }); 

CS_Posts.belongsTo(ClubSports, { foreignKey: 'clubSportID'})
ClubSports.hasMany(CS_Posts, { foreignKey: 'clubSportID'})

Connects.belongsTo(User, { foreignKey: 'userID', as: 'user' });
User.hasMany(Connects, { foreignKey: 'userID' });

User.hasMany(Posts, { foreignKey: 'userID' });
Posts.belongsTo(User, { foreignKey: 'userID' });

Posts.hasMany(Likes, {foreignKey :'postID', onDelete:"CASCADE", hooks:true})
Likes.belongsTo(Posts, { foreignKey: 'postID' })

Posts.hasMany(Comments, {foreignKey :'postID', onDelete:"CASCADE", hooks:true})
Comments.belongsTo(Posts, { foreignKey: 'postID' })

User.hasMany(Likes, {foreignKey :'userID', onDelete:"CASCADE", hooks:true})
Likes.belongsTo(User, { foreignKey: 'userID' })

User.hasMany(Comments, {foreignKey :'userID', onDelete:"CASCADE", hooks:true})
Comments.belongsTo(User, { foreignKey: 'userID' })
