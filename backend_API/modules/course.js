import { sequelize } from '../config/sequelizeDB.js';
import { DataTypes } from 'sequelize';

export const Course = sequelize.define('course_tb', {
    courseID: {
        type: DataTypes.STRING(30),
        primaryKey: true,
    },
    courseName: {
        type: DataTypes.STRING(100),
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