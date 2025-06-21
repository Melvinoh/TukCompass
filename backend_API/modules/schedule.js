import {sequelize} from "../config/sequelizeDB.js"
import {DataTypes} from "sequelize"
import {UnitOffering} from "./unitOffering.js"

 export const Schedule = sequelize.define("schedule_tb", {

    scheduleID:{
        type: DataTypes.STRING(40),
        primaryKey: true,
        defaultValue: DataTypes.UUIDV4(30)
    },
    unitOfferingID:{
        type: DataTypes.STRING(40),
        allowNull: false,
         references:{
            model:UnitOffering,
            key:"unitOfferingID"
        }
    },
    day:{
        type: DataTypes.STRING(10),
        allowNull: false
    },
    startTime:{
        type: DataTypes.STRING(10),
        allowNull: false
    },
    endTime:{
        type: DataTypes.STRING(10),
        allowNull: false,
    },
    mode:{
        type: DataTypes.STRING(10),
        defaultValue: "online"
    }
})