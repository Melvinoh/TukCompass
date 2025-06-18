import {Class} from "../modules/class.js"


export const addClass = async (req,res)=>{

    const{ classID, className, courseID, classRep} = req.body

    try {
        const newClass = await Class.create({classID, className, courseID, classRep})
        res.status(201).json({message : "class added succefully", class : newClass})
    } catch (error) {
        res.status(500).json({err: 'failed to add class', message:error.message})
    }

}