import {School} from "../modules/schools.js"


export const addSchool = async (req,res)=>{

    const{ schoolID, schoolName, facultyID, schoolHeadID} = req.body

    try {
        const newSchool = await School.create({schoolID, schoolName, facultyID, schoolHeadID})
        res.staus(201).json({message : "school added succefully", school : newSchool})
    } catch (error) {
        res.status(500).json({err: 'failed to add school', message:error.message})
    }

}