import {User} from "../modules/Users.js"
import {Student} from "../modules/students.js"
import {Lecturer} from "../modules/lecturers.js"
import bcrypt from "bcrypt"

export const userRegistration = async (req, res ) =>{

    const t =  await sequelize.transaction()

    try {
        const{ userID, fname, sname, email, password, role, mobile}= req.body
        
        const salt =  await bcrypt.genSaltSnyc(10)
        const hashPasword = await bcrypt.hashSync(password, salt)

        const newUser = await User.create({userID, fname, sname, email, hashPasword, role, mobile }, {transaction: t })

        if (role === 'student') {

           await Student.create({studentID : userID, courseID, classID },{transaction : t})
            
        }else if (role === 'lecturer') {
            await Lecturer.create({lecturerID: userID, departmentID})
        }
        await t.commit()
        res.status(201).json({message: " user registered succefully" , user: newUser})

    } catch (err) {
        await t.rollback()
        res.status(500).json({error :"request failed", message: err.message})
        
    }
}
