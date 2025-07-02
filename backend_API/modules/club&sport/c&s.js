import { sequelize } from '../../config/sequelizeDB.js';
import { DataTypes } from 'sequelize';
import {User} from "../Users.js"

export const ClubSports = sequelize.define('c&s_tb', {
    clubSportsID:{
        type: DataTypes.STRING(40),
        primaryKey: true,
    },
    name: {
        type: DataTypes.STRING(30)
    },
    type: {
        type: DataTypes.ENUM('clubs','sports')
    },
    profileURL: {
        type: DataTypes.STRING(100)
    },
    coverURL: {
        type: DataTypes.STRING(100)
    },
    description: {
        type: DataTypes.STRING
    },
    patron: {
        type: DataTypes.STRING(100),
        references:{
            model: User,
            key: "userID"
        }
    }
});