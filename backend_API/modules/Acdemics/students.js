import { sequelize} from '../../config/sequelizeDB.js ';
import { DataTypes } from 'sequelize';
import { User } from '../Users.js';
import { Class } from './class.js';


export const Student = sequelize.define('students_tb', {
    studentID: {
        type: DataTypes.STRING(30),
        primaryKey: true,
        references: {
            model: User,
            key: 'userID'
        }
    },
    courseID: {
        type: DataTypes.STRING(30),
        references: {
            model: 'course_tb', // Assuming the course model is defined in course.js
            key: 'courseID'
        }
    },
    classID: {
        type: DataTypes.STRING(30),
        references: {
            model: Class,
            key: 'classID'
        }
    },
});