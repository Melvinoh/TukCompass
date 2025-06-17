import { sequelize } from "../config/sequelizeDB.js";
import { DataTypes } from 'sequelize';  
import { User } from "./Users.js";
import { Course } from "./course.js";

export const Class = sequelize.define('class_tb', {
    classID: {
        type: DataTypes.STRING(30),
        primaryKey: true,
    },
    className: {
        type: DataTypes.STRING(50),
        allowNull: false,
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
    }
});

