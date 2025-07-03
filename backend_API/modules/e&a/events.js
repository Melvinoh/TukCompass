import { sequelize } from "../../config/sequelizeDB.js";
import { DataTypes } from "sequelize";
import { User } from "../Users.js";

export const Events = sequelize.define('events_tb',{
    eventID:{
        type: DataTypes.STRING(40),
        primaryKey: true,
        defaultValue: DataTypes.UUIDV4()
    },
    title:{
        type: DataTypes.STRING(40),
    },
    description:{
        type: DataTypes.TEXT,
    },
    location:{
        type: DataTypes.STRING(30),
    },
    date:{
        type: DataTypes.STRING(40),
    },
    expireyDate:{
        type: DataTypes.STRING(40),
    },
    time:{
        type: DataTypes.STRING(40),
    },
    targetGroup:{
        type: DataTypes.ENUM('all','lecturers','specific'),
    },
    fileUrl:{
        type: DataTypes.TEXT,
    },
    createdBy:{
        type: DataTypes.STRING(20),
        references: {
            model: User,
            key: 'userID'
        }
    },
    createdAt:{
        type: DataTypes.STRING(20),
    },
})