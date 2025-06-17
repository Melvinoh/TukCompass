import { sequelize } from '../config/sequelizeDB.js';
import { DataTypes } from 'sequelize';
import { School } from './schools.js'; 
import { User } from './Users.js';

export const Department = sequelize.define('department_tb', {
    departmentID: {
        type: DataTypes.STRING(30),
        primaryKey: true,
    },
    departmentName: {
        type: DataTypes.STRING(50),
        allowNull: false,
    },
    schoolID: {
        type: DataTypes.STRING(30),
        references: {
            model:  School,
            key: 'schoolID'
        }
    },
    departmentHeadID: {
        type: DataTypes.STRING(30),
        references: {
            model: User,
            key: 'userID'
        }
    }
});