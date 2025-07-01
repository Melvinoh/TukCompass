import { sequelize } from '../../config/sequelizeDB.js';
import { DataTypes } from 'sequelize';
import {User} from "../Users.js"
import {ClubSports} from "./c&s.js"

export const CS_Members = sequelize.define('c&sMembers_tb', {
    csMemberID:{
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
    userID: {
        type: DataTypes.STRING(40),
        references:{
            model: User,
            key: "userID"
        }
    }
});