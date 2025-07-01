import { Faculty } from "../../modules/Acdemics/Faculty.js"

export const addFaculty = async (req, res) =>{

    const{ facultyID, facultyName, deanID} = req.body
    try {
        const newFaculty = await Faculty.create({facultyID,facultyName})
        res.status(201).json( {message :"faculty created succeffully", faculty:newFaculty})
    } catch (error) {
        res.status(500).json({ err:"failed to insert faculty", message: error.message})
    }

}
