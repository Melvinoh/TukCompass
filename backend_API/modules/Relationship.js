import {User} from "./Users.js"
import {Faculty}from "./Faculty.js"
import { School } from "./schools.js"
import { Course } from "./course.js"
import { Class } from "./class.js"
import { Department } from "./department.js";
import {Student} from "./students.js"
import { Lecturer } from "./lecturers.js"
import { Unit } from "./units.js"
import { CourseUnit } from "./courseUnit.js";
import { LecturerUnits } from "./lecturerUnits.js"


// Define relationships between models

Faculty.hasMany(School, {foreignKey :' facultyID', onDelete:"CASCADE", hooks:true})
School.belongsTo(Faculty, { foreignKey: 'facultyID' })

School.hasMany(Department, { foreignKey: 'schoolID', onDelete:"CASCADE", hooks:true })
Department.belongsTo(School, { foreignKey: 'schoolID' })

Department.hasMany(Course, { foreignKey: 'departmentID', onDelete:"CASCADE", hooks:true })
Course.belongsTo(Department, { foreignKey: 'departmentID' })

Course.hasMany(Class, { foreignKey: 'courseID', onDelete:"CASCADE", hooks:true })
Class.belongsTo(Course, { foreignKey: 'courseID' })

Student.belongsTo(Class, { foreignKey: 'classID' })
Class.hasMany(Student, { foreignKey: 'classID' })

Student.belongsTo(Course, { foreignKey: 'courseID' })
Course.hasMany(Student, { foreignKey: 'courseID' })

Class.belongsTo(User, { foreignKey: 'classRep' })
Department.belongsTo(User, { foreignKey: 'departmentHeadID' })
School.belongsTo(User, { foreignKey: 'schoolHeadID' })
Faculty.belongsTo(User, { foreignKey: 'deanID'})

// Define relationships for Lecturers Students and users

Lecturer.belongsTo(User, { foreignKey: 'lecturerID' })
User.hasMany(Lecturer, { foreignKey: 'lecturerID' })

Student.belongsTo(User, { foreignKey: 'userID' })
User.hasMany(Student, { foreignKey: 'studentID' })

Unit.belongsToMany(Course,{ through : CourseUnit, foreignKey: 'unitID'})
Course.belongsToMany(Unit, { through: CourseUnit, foreignKey: 'courseID' })

Unit.belongsToMany(Lecturer, { through: LecturerUnits, foreignKey: 'unitID' })
Lecturer.belongsToMany(Unit, { through: LecturerUnits, foreignKey: 'lecturerID' })





