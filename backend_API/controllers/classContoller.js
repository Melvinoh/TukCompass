import {Class} from "../modules/class.js"


export const addClass = async (req,res)=>{

    const{ classID, className, courseID, classRep, enrolmentYear,completionYear} = req.body

    try {

        const calendar = await getYearSemister(enrolmentYear);

        const newClass = await Class.create({
            classID:classID,
            courseID: courseID,
            enrolmentYear: enrolmentYear,
            completionYear:completionYear,
            currentYear: calendar.Year,
            currentSem: calendar.semister,
            academicYear: calendar.academicYear
        })
        

        res.status(201).json({message : "class added succefully", class : newClass})
    } catch (error) {
        res.status(500).json({err: 'failed to add class', message:error.message})
    }

}
const getYearSemister = (enrolmentYear)=>{
    
    const date = new Date();

    const currentYear = date.getFullYear();
    const currentMonth = date.getMonth() + 1;

    const startYear = currentMonth >= 9? currentYear + 1 : currentYear - 1
    const endYear = startYear + 1
    const academicYear = `${startYear}/${endYear}`;

    let sos = null;

    if (currentMonth >= 9 && currentMonth <= 12){
        sos = 1
    };
    if (currentMonth >= 1 && currentMonth <= 4){
        sos = 2
    };
    if (currentMonth >= 5 && currentMonth <= 8){
        sos = 3
    };

    const Yos = sos === 1 ? currentYear - enrolmentYear + 1  : currentYear - enrolmentYear ;

    return (
        {
            Year:Yos,
            semister:sos,
            academicYear:academicYear
        }
    )

}