
import {sequelize} from "../../config/sequelizeDB.js"
import { Faculty } from "../../modules/Acdemics/Faculty.js";
import { School } from "../../modules/Acdemics/schools.js";
import { Department } from "../../modules/Acdemics/department.js";


export const adminPanel = async (res, req)=>{
    
    const{facultyID, facultyName, deanID, schools} = req.body
    const t = await sequelize.transaction()
  
    try {
        if(!facultyID,!facultyName,!schools){
            res.status(400).json({ message:"important fields are required"})
        }

        await Faculty.create({facultyID, facultyName},{transaction:t})

        for( const school of schools ){
            await School.create({
                schoolID: school.schoolID,
                schoolName: school.schoolName,
                facultyID
            },{transaction:t})

            for(const dept of school.departments){
                await Department.create({
                    departmentID:dept.departmentID,
                    departmentName:dept.departmentName,
                    schoolID:school.schoolID
                },{transaction:t})
                res.status(201).json({
                    message:"faculty schools and its departments are created succefully"
                })
            }
        }
    }
    catch(err){

        console.error(err)
        res.status(500).json({
            message:"could not add record ",
            error: err.message
        })
    }
}