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
import {UnitOffering} from "./unitOffering.js"
import {UnitEnrollment} from "./unitEnrollment.js"
import {Schedule} from "./schedule.js"
import {ScheduleCourse} from "./scheduleCourse.js"


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

Student.belongsTo(User, { foreignKey: 'studentID' })
User.hasMany(Student, { foreignKey: 'studentID' })

Unit.belongsToMany(Course,{ through : CourseUnit, foreignKey: 'unitID'})
Course.belongsToMany(Unit, { through: CourseUnit, foreignKey: 'courseID' })

//many to many relationships

Schedule.belongsToMany(Course, { through: ScheduleCourse, foreignKey: 'scheduleID' })
Course.belongsToMany(Schedule, { through: ScheduleCourse, foreignKey: 'courseID' })

Unit.belongsToMany(Lecturer, { through: UnitOffering, foreignKey: 'unitID' })
Lecturer.belongsToMany(Unit, { through: UnitOffering, foreignKey: 'lecturerID' })

UnitOffering.belongsToMany(Student, { through: UnitEnrollment, foreignKey: 'unitOfferingID' })
Student.belongsToMany(UnitOffering, { through: UnitEnrollment, foreignKey: 'studentID' })





