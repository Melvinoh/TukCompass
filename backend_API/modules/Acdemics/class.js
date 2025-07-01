import { sequelize } from "../../config/sequelizeDB.js";
import { DataTypes } from 'sequelize';  
import { User } from "../Users.js";
import { Course } from "./course.js";

export const Class = sequelize.define('class_tb', {
    classID: {
        type: DataTypes.STRING(30),
        primaryKey: true,
    },
    courseID: {
        type: DataTypes.STRING(30),
        references: {
            model: Course,
            key: 'courseID'
        }
    },
    classRep: {
        type: DataTypes.STRING(30),
        references: {
            model: User,
            key: 'userID'
        }
    },
    enrolmentYear:{
        type: DataTypes.INTEGER(6)
    },
    completionYear:{
        type: DataTypes.INTEGER(6)
    },
    currentYear:{
        type: DataTypes.INTEGER(4),
    },
    currentSem:{
        type: DataTypes.INTEGER(4),
    },
    academicYear:{
        type: DataTypes.STRING(10)
    }
});

