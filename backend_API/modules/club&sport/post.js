import { sequelize } from '../../config/sequelizeDB.js';
import { DataTypes } from 'sequelize';
import {User} from "../Users.js"

export const Posts = sequelize.define('posts_tb', {
    postID: {
        type: DataTypes.STRING(40),
        primaryKey: true,
        defaultValue: DataTypes.UUIDV4(30)
    },
    description: {
        type: DataTypes.STRING
    },
    imageURL: {
        type: DataTypes.STRING(100)
    },
    date: {
        type: DataTypes.STRING(20)
    },
    userID: {
        type: DataTypes.STRING(100),
        references:{
            model: User,
            key: "userID"
        }
    },
});