import {Department} from "../modules/department.js"


export const addDepartment= async (req,res)=>{

    const{ departmentID, departmentName, schoolID, departmentHeadID} = req.body

    try {
        const newDepartment = await Department.create({departmentID, departmentName, schoolID})
        res.status(201).json({message : "department added succefully", department : newDepartment})
    } catch (error) {
        res.status(500).json({err: 'failed to add department', message:error.message})
    }

}