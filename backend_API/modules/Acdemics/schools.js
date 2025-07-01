import { sequelize} from "../../config/sequelizeDB.js"
import {DataTypes} from "sequelize"
import { Faculty } from "./Faculty.js"
import { User } from "../Users.js"

export const School = sequelize.define( 'school_tb' , {
    schoolID: {
        type: DataTypes.STRING(30),
        primaryKey: true,
    },
    schoolName: {
        type: DataTypes.STRING(100),
        allowNull: false
    },
    facultyID: {
        type: DataTypes.STRING(30),
        references: {
            model: Faculty,
            key: 'facultyID'
        }
    },
    schoolHeadID: {
        type: DataTypes.STRING(30),
        references: {
            model: User,
            key: 'userID'
        }
    }
})