import { sequelize } from '../config/sequelizeDB.js'
import { DataTypes } from 'sequelize'
import { User } from './Users.js';

export const Lecturer = sequelize.define('lecturers_tb', {
    lecturerID: {
        type: DataTypes.STRING(30),
        primaryKey: true,
        references: {
            model: User,
            key: 'userID'
        }
    },
    lecturerName: {
        type: DataTypes.STRING(50),
        allowNull: false,
    },
    departmentID: {
        type: DataTypes.STRING(30),
        references: {
            model: 'department_tb',
            key: 'departmentID'
        }
    },
});
