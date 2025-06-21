import {User} from "../modules/Users.js"
import {sequelize} from "../config/sequelizeDB.js"
import {Student} from "../modules/students.js"
import {Course} from "../modules/course.js"
import {Class} from "../modules/class.js"
import {Department} from "../modules/department.js"
import {Lecturer} from "../modules/lecturers.js"
import bcrypt from "bcrypt"

export const userRegistration = async (req, res) =>{

    const t =  await sequelize.transaction()

    try {
        const{ fname, sname, email, userID,  role, mobile, courseName, enrolmentYear, password,departmentName}= req.body

        const salt = bcrypt.genSaltSync(10);
        const hashPassword = bcrypt.hashSync(password, salt);

        const newUser = await User.create({
            userID, 
            fname, 
            sname, 
            email, 
            password: hashPassword,
            role,
            mobile
         }, {transaction: t })

        if (role === 'student') {

            const course = await Course.findOne({where:{courseName},transaction: t})

            if(!course){
                res.status(404).json({message:"course not found"})
            }
            const classRec = await Class.findOne({
                where:{
                    courseID: course.courseID,
                    enrolmentYear:enrolmentYear
                },
                transaction: t
            });
            if(!classRec){
                res.status(404).json({message:"course not found"})
            }
    
            const newStudent = await Student.create({
                studentID : userID,
                courseID: course.courseID,
                classID: classRec.classID
            },{transaction : t})
            
        }else if (role === 'lecturer') {

            const department = await Department.findOne({where:{departmentName},transaction: t})
            if(!department){
                res.status(404).json({message:"department not found"})
            }
            const lecturer = await Lecturer.create({
                lecturerID: userID,
                departmentID: department.departmentID
            }, {transaction:t})
        }
        await t.commit()
        res.status(201).json({message: " user registered succefully" , user: newUser})

    } catch (err) {
        await t.rollback()
        res.status(500).json({error :"request failed", message: err.message})
        
    }
}
