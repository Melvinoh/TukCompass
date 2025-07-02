import { sequelize } from '../../config/sequelizeDB.js';
import { DataTypes } from 'sequelize';
import {User} from "../Users.js"


export const Connects = sequelize.define('connects_tb', {
    connectID:{
        type: DataTypes.STRING(40),
        primaryKey: true,
        defaultValue: DataTypes.UUIDV4(30)
    },
    followingID: {
        type: DataTypes.STRING(40),
        references:{
            model: User,
            key:"userID"
        }
    },
    followerID: {
        type: DataTypes.STRING(40),
        references:{
            model: User,
            key: "userID"
        }
    }
});