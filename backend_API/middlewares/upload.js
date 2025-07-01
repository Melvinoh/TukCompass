import multer from "multer"
import path from "path"


const storage = multer.diskStorage({
    destination: (req,file,cb) =>{
        cb(null, "/tmp")
    },
    filename: (req,file,cb) =>{
        const ext = path.extname(file.originalname)
        cb( null, `${Date.now()}-${file.originalname}`)
    }
})

export const upload = multer({storage})