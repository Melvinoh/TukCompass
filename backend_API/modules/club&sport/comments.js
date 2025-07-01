import { sequelize } from '../../config/sequelizeDB.js';
import { DataTypes } from 'sequelize';
import {User} from "../Users.js"
import {Posts} from "./post.js"

export const Comments = sequelize.define('comments_tb', {
    commentID:{
        type: DataTypes.STRING(40),
        primaryKey: true,
        defaultValue: DataTypes.UUIDV4(30)
    },
    description:{
        type: DataTypes.STRING
    },
    postID: {
        type: DataTypes.STRING(40),
        references:{
            model: Posts,
            key:"postID"
        }
    },
    userID: {
        type: DataTypes.STRING(20),
        references:{
            model: User,
            key: "userID"
        }
    }

});