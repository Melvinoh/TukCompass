import {sequelize} from "../config/sequelizeDB.js"
import {DataTypes} from "sequelize"
import {Student} from "./students.js"
import {UnitOffering} from "./unitOffering.js"

 export const UnitEnrollment = sequelize.define("unitEnrollment_tb", {

    unitEnrollmentID:{
        type: DataTypes.STRING(40),
        primaryKey: true,
        defaultValue: DataTypes.UUIDV4(30)
    },
    studentID:{
        type: DataTypes.STRING(30),
        allowNull: false,
        references:{
            model: Student,
            key:"studentID"
        }
    },
    unitOfferingID:{
        type: DataTypes.STRING(40),
        allowNull: false,
         references:{
            model:UnitOffering,
            key:"unitOfferingID"
        }
    },
    enrollmentDate:{
        type: DataTypes.INTEGER(10),
        allowNull: false
    },
    status:{
        type: DataTypes.ENUM("active", "complited"),
        defaultValue: "active"
    }
  
})