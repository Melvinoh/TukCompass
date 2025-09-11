import{DataTypes} from 'sequelize'
import {sequelize} from '../config/sequelizeDB.js';

 export const User = sequelize.define('user_tb', {
    userID:{
        type: DataTypes.STRING(30),
        allowNull:false,
        primaryKey:true
    },
    fname:{
        type: DataTypes.STRING(15),
        allowNull : false
    },
    sname:{
        type: DataTypes.STRING(15),
        allowNull : false
    },
    email:{
        type: DataTypes.STRING(30),
        allowNull : false,
        unique: true
    },
    password:{
        type: DataTypes.STRING(100),
        allowNull: false
    },
    role:{
        type: DataTypes.ENUM('student','lecturer','admin'),
        defaultValue:'student'
    },
    mobile:{
        type: DataTypes.STRING(15),
    },
    profileUrl:{
        type: DataTypes.STRING(100),
    },
})