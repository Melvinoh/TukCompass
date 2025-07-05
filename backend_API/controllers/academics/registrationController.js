import { User } from "../../modules/Users.js"
import {sequelize} from "../../config/sequelizeDB.js"
import {Student} from "../../modules/Acdemics/students.js"
import {Course} from "../../modules/Acdemics/course.js"
import {Class} from "../../modules/Acdemics/class.js"
import {Department} from "../../modules/Acdemics/department.js"
import { Lecturer } from "../../modules/Acdemics/lecturers.js"
import bcrypt from "bcrypt"
import fs from "fs/promises"
import { cloudinary } from "../../config/cloudinary.js"

export const userRegistration = async (req, res) =>{

    const t =  await sequelize.transaction();
    try {
        const{ fname, lname, email, userID,  role, courseName, enrolmentYear, password,departmentName}= req.body
        const salt = bcrypt.genSaltSync(10);
        const hashPassword = bcrypt.hashSync(password, salt);
        const newUser = await User.create({
            userID, 
            fname, 
            sname: lname, 
            email, 
            password: hashPassword,
            role,
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

export const updateUser = async (req, res) =>{
    const { fname, lname, email, mobile } = req.body;

    const {userID} = req.user;

    const file = req.file;
    if(!file){
        res.status(400).json({
            message:"no file uploaded"
        })
    }
    try {

        const profileUrl = await cloudinary.uploader.upload(file.path, {
            resource_type: "image",
            folder: "profile",
            public_id: file.originalname
                .split(".")[0]
                .replace(/\s+/g, "_")
                .replace(/[^a-zA-Z0-9_-]/g, "")
        })

        await fs.unlink(file.path)

        const user = await User.findOne({ where: { userID } });

        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }

        user.fname = fname || user.fname;
        user.sname = lname || user.sname;
        user.email = email || user.email;
        user.mobile = mobile || user.mobile;
        user.profileUrl = profileUrl.secure_url || user.profileUrl;

        await user.save();

        res.status(200).json({ message: "User updated successfully", user });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "An error occurred while updating the user", error: error.message });
    }

}
