import { sequelize } from "../../config/sequelizeDB.js";
import { DataTypes } from "sequelize";
import { User } from "../Users.js";
import { School } from "../Acdemics/schools.js";

export const Announcements = sequelize.define('announcment_tb',{
    announcmentID:{
        type: DataTypes.STRING(40),
        primaryKey: true,
        defaultValue: DataTypes.UUIDV4()
    },
    title:{
        type: DataTypes.STRING(40),
    },
    message:{
        type: DataTypes.TEXT,
    },
    fileUrl:{
        type: DataTypes.TEXT,
    },
    date:{
        type: DataTypes.STRING(40),
    },
    targetGroup:{
        type: DataTypes.ENUM('all','lecturers','specific'),
    },
    schoolID:{
        type: DataTypes.STRING(20),
        references: {
            model: School,
            key: 'schoolID'
        }
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
