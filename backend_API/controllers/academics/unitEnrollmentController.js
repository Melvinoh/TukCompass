import { UnitEnrollment } from "../../modules/Acdemics/unitEnrollment.js";
import { Student } from "../../modules/Acdemics/students.js";
import { UnitOffering } from "../../modules/Acdemics/unitOffering.js";
import { Unit } from "../../modules/Acdemics/units.js";
import { Lecturer } from "../../modules/Acdemics/lecturers.js";

export const enrollStudentInUnit = async (req, res) => {
  try {
    const { studentID, unitOfferingID } = req.body;

    const existing = await UnitEnrollment.findOne({
      where: { studentID, unitOfferingID }
    });

    if (existing) {
      return res.status(400).json({ message: "Already enrolled in this unit" });
    }

    const enrollment = await UnitEnrollment.create({ studentID, unitOfferingID });
    res.status(201).json({ message: "Enrollment successful", enrollment });

  } catch (error) {
    console.error("Error enrolling:", error);
    res.status(500).json({ message: "Internal server error" });
  }
};

export const getEnrolledUnits = async (req, res) => {

  try {

    const studentID = req.user.userID
    const enrolmentYear = 2021
    const calendar = await getYearSemister(enrolmentYear);

    const enrolledUnits = await UnitEnrollment.findAll({
      where: { studentID },
      include: {
        model: UnitOffering,
        where: { 
          academicYear: calendar.academicYear,
          year: calendar.Year,
          sem: calendar.semister
        },
        include: [
          { model: Unit },
          { model: Lecturer }
        ]
      }
    });

    res.status(200).json({ enrolledUnits });
  } catch (error) {
    console.error("Error fetching enrolled units:", error);
    res.status(500).json({ 
      message: "Internal server error",
      error: error.message 
    });
  }
};

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







