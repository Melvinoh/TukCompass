import { sequelize } from '../../config/sequelizeDB.js';
import { DataTypes } from 'sequelize';
import {Posts} from "./post.js"
import {ClubSports} from "./c&s.js"

export const CS_Posts = sequelize.define('csPosts_tb', {
    csPostID:{
        type: DataTypes.STRING(40),
        primaryKey: true,
        defaultValue: DataTypes.UUIDV4(30)
    },
    clubSportID: {
        type: DataTypes.STRING(40),
        references:{
            model: ClubSports,
            key:"clubSportsID"
        }
    },
    postID: {
        type: DataTypes.STRING(40),
        references:{
            model: Posts,
            key: "postID"
        }
    }
});