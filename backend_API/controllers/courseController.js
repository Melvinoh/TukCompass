import {Course} from "../modules/course.js"


export const addCourse = async (req,res)=>{

    const{ courseID, courseName, departmentID} = req.body

    try {
        const newCourse = await Course.create({courseID, courseName, departmentID, courseHeadID})
        res.status(201).json({message : "course added succefully", course : newCourse})
    } catch (error) {
        res.status(500).json({err: 'failed to add course', message:error.message})
    }

}