import { sequelize } from "../../config/sequelizeDB.js";
import { DataTypes } from "sequelize";
import { User } from "../Users.js";

export const Announcements = sequelize.define('announcment_tb',{

    announcmentID:{
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
        defaultValue: 'all'
    },
    createdBy:{
        type: DataTypes.STRING(20),
        references: {
            model: User,
            key: 'userID'
        }
    },
})
