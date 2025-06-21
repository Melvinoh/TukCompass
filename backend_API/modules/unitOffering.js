import {sequelize} from "../config/sequelizeDB.js"
import {DataTypes} from "sequelize"
import {Lecturer} from "./lecturers.js"
import {Unit} from "./units.js"

 export const UnitOffering = sequelize.define("unitOffering_tb", {

    unitOfferingID:{
        type: DataTypes.STRING(40),
        primaryKey: true,
        defaultValue: DataTypes.UUIDV4(30)
    },
    lecturerID:{
        type: DataTypes.STRING(30),
        allowNull: false,
        references:{
            model: Lecturer,
            key:"lecturerID"
        }
    },
    unitID:{
        type: DataTypes.STRING(30),
        allowNull: false,
          references:{
            model: Unit,
            key:"unitID"
        }
    },
    academicYear:{
        type: DataTypes.INTEGER(10),
        allowNull: false
    },
    year:{
        type: DataTypes.INTEGER(5),
        allowNull: false
    },
    sem:{
        type: DataTypes.INTEGER(5),
        allowNull: false
    }

})