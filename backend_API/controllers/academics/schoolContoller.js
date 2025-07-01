import { School } from "../../modules/Acdemics/schools.js"

export const addSchool = async (req,res)=>{

    const{ schoolID, schoolName, facultyID, schoolHeadID} = req.body
    
    try {
        const newSchool = await School.create({schoolID, schoolName, facultyID})
        res.status(201).json({message : "school added succefully", school : newSchool})
    } catch (error) {
        console.error(error)
        res.status(500).json({err: 'failed to add school', message:error.message})
    }

}