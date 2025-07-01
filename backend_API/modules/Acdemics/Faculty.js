import {sequelize} from "../../config/sequelizeDB.js"
import {User} from "../Users.js"
import{DataTypes}from "sequelize"
export const Faculty = sequelize.define('faculty_tb', {
    facultyID :{
        type: DataTypes.STRING(30),
        primaryKey: true,
    },
    facultyName:{
        type: DataTypes.STRING(50),
    },
    deanID:{
        type: DataTypes.STRING(30),
        refernces:{
            model: User,
            key: 'userID'
        }
    }
});
