import {sequelize} from "../../config/sequelizeDB.js"
import {DataTypes} from "sequelize"
import {Schedule} from "./schedule.js"
import {Course} from "./course.js"

 export const ScheduleCourse = sequelize.define("scheduleCourse_tb", {

    scheduleCourseID:{
        type: DataTypes.STRING(40),
        primaryKey: true,
        defaultValue: DataTypes.UUIDV4(30)
    },
    courseID:{
        type: DataTypes.STRING(30),
        allowNull: false,
        references:{
            model: Course,
            key:"courseID"
        }
    },
    scheduleID:{
        type: DataTypes.STRING(30),
        allowNull: false,
         references:{
            model: Schedule,
            key:"scheduleID"
        }
    }, 
})