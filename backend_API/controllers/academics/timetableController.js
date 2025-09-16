import {UnitOffering} from "../../modules/Acdemics/unitOffering.js";
import {Student} from "../../modules/Acdemics/students.js";
import { Lecturer} from "../../modules/Acdemics/lecturers.js";
import { Unit } from "../../modules/Acdemics/units.js";
import { ScheduleCourse } from "../../modules/Acdemics/scheduleCourse.js";
import {Class} from "../../modules/Acdemics/class.js";
import { CourseUnit } from "../../modules/Acdemics/courseUnit.js";
import { Course } from "../../modules/Acdemics/course.js";
import { Schedule } from "../../modules/Acdemics/schedule.js";
import { User } from "../../modules/Users.js"



export const getStudentsTimetable = async (req, res) => {

  const studentID  = req.user.userID;
  try {

    const student = await Student.findByPk(studentID, {
      include: [
        {model: Class},
        { model: Course}
      ],
    });

    if (!student) {
      return res.status(404).json({ message: "Student not found" });
    }

    const enrolmentYear = student.class_tb?.enrolmentYear;
    const courseID = student.course_tb?.courseID;
    if (!enrolmentYear || !courseID) {
      return res.status(400).json({ message: "Student missing class or course info" });
    }
    const {Year,semister,academicYear} = getYearSemister(enrolmentYear);

    const schedule = await ScheduleCourse.findAll({ where: { courseID }, include: { model: Schedule, include: [ { model: UnitOffering, attributes: ['unitID','unitOfferingID'], where: { year: Year, sem: semister, academicYear }, include: [ { model: Unit }, { model: Lecturer } ] } ] } });
   // Debug/log to inspect shape when something unexpected happens
    console.log("getStudentsTimetable - primary schedule length:", schedule.length);
    if (process.env.NODE_ENV !== 'production') {
      console.log("getStudentsTimetable - schedule sample:", JSON.stringify(schedule, null, 2));
    }

     // Fallback: if first query returned nothing, try a looser query (no academicYear filter) to help diagnose

    if (!schedule || schedule.length === 0) {
      console.warn("No schedule rows matched year/sem/academicYear filter - trying a looser query for debugging.");
      schedule = await ScheduleCourse.findAll({
        where: { courseID },
        include: [{
          model: Schedule,
          include: [{
            model: UnitOffering,
            attributes: ['unitID', 'unitOfferingID', 'academicYear', 'year', 'sem'],
            where: {
              year: Year,
              sem: semister
            },
            include: [
              { model: Unit },
              { model: Lecturer, include: [{ model: User, attributes: ['fname', 'sname'] }] }
            ]
          }]
        }]
      });
    }

    const sessions = schedule.map(sc => {
      const sched = sc.schedule_tb;
      const unitOffering = sched?.unitOffering_tb;

      if (!sched || !unitOffering || !unitOffering.units_tb || !unitOffering.lecturers_tb) {
        return null;
      }

      return {
        day: capitalizeDay(sched.day),
        startTime: formatTime(sched.startTime),
        endTime: formatTime(sched.endTime),
        unitName: unitOffering.units_tb.unitName,
        unitID: unitOffering.units_tb.unitID,
        unitOfferingID: unitOffering.unitOfferingID,
        lecturerName: unitOffering.lecturers_tb.lecturerID,
        mode: sched.mode
      };
    }).filter(Boolean);

    const timetable = transformToFixedTimetable(sessions);

    return res.status(200).json({
      timetable: timetable
      
    });
    
  } catch (error) {
    console.error("Error fetching student's timetable:", error);
    return res.status(500).json({
      message: "Internal server error",
      error: error.message
    });
  }
}

const getYearSemister = (enrolmentYear)=>{
    const date = new Date();

    const currentYear = date.getFullYear();
    const currentMonth = date.getMonth() + 1;

    const startYear = currentMonth >= 10? currentYear  : currentYear - 1
    const endYear = startYear + 1
    const academicYear = `${startYear}/${endYear}`;

    let sos = null;

    if (currentMonth >= 12 && currentMonth <= 4){
        sos = 1
    };
    if (currentMonth >= 5 && currentMonth <= 9){
        sos = 2
    };
    if (currentMonth >= 10 && currentMonth <= 11){
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

const formatTime = timeStr => {
  const [h, m] = timeStr.split(":");
  return `${h.padStart(2, "0")}:${m.padStart(2, "0")}`;
};

const FIXED_SLOTS = [
  { startTime: "07:00", endTime: "09:00" },
  { startTime: "09:00", endTime: "11:00" },
  { startTime: "11:00", endTime: "13:00" },
  { startTime: "14:00", endTime: "16:00" },
  { startTime: "16:00", endTime: "18:00" }
];

function capitalizeDay(day) {
  return day.charAt(0).toUpperCase() + day.slice(1).toLowerCase();
}

const transformToFixedTimetable = (sessions) => {

  const timetable = FIXED_SLOTS.map(slot => ({
    startTime: slot.startTime,
    endTime: slot.endTime,
    key: `${slot.startTime}-${slot.endTime}`,
    sessions: {
      Monday: null,
      Tuesday: null,
      Wednesday: null,
      Thursday: null,
      Friday: null
    }
  }))
  for (const s of sessions) {
    const key = `${s.startTime}-${s.endTime}`;
    const slot = timetable.find(t => t.key === key);
    if (slot) {
      slot.sessions[s.day] = {
        unitName: s.unitName,
        unitID: s.unitID,
        unitOfferingID: s.unitOfferingID,
        lecturerName: s.lecturerName,
        mode: s.mode
      };
    }
  }

  return timetable;
};



export const getLecturerTimetable = async (req, res) => {
  const lecturerID = req.user.userID; // assuming userID === lecturerID

  try {
    // Fetch lecturer with user details
    const lecturer = await Lecturer.findByPk(lecturerID, {
      include: [{ model: User, attributes: ["fname", "sname"] }]
    });

    if (!lecturer) {
      return res.status(404).json({ message: "Lecturer not found" });
    }

    // Fetch all unit offerings for this lecturer (no year/sem filters)
    const unitOfferings = await UnitOffering.findAll({
      where: { lecturerID },
      include: [
        {
          model: Unit,
          attributes: ["unitID", "unitName"],
          include: [
            {
              model: CourseUnit,
              include: [{ model: Course, attributes: ["courseID", "courseName"] }]
            }
          ]
        },
        {
          model: Lecturer,
          include: [{ model: User, attributes: ["fname", "sname"] }]
        },
        {
          model: Schedule,
          attributes: ["day", "startTime", "endTime", "mode"]
        }
      ]
    });

    console.log("getLecturerTimetable - offerings:", unitOfferings.length);

    const sessions = [];
    for (const uo of unitOfferings) {
      const unit = uo.Unit;

      // ✅ extract course name from Unit -> CourseUnit -> Course
      let courseName = null;
      if (unit?.CourseUnits?.length > 0) {
        courseName = unit.CourseUnits[0].Course?.courseName || null;
      }

      // ✅ lecturer name from related User
      const lecturerUser = uo.Lecturer?.User;
      const lecturerName = lecturerUser
        ? `${lecturerUser.fname} ${lecturerUser.sname}`
        : uo.lecturerID;

      // ✅ loop through schedules for this unit offering
      const schedules = uo.Schedules || [];
      for (const sched of schedules) {
        sessions.push({
          day: capitalizeDay(sched.day),
          startTime: formatTime(sched.startTime),
          endTime: formatTime(sched.endTime),
          unitName: unit?.unitName || null,
          unitID: unit?.unitID || uo.unitID,
          unitOfferingID: uo.unitOfferingID,
          lecturerName,
          courseName,
          mode: sched.mode
        });
      }
    }

    const timetable = transformToFixedTimetable(sessions);

    return res.status(200).json({ timetable });
  } catch (error) {
    console.error("Error fetching lecturer timetable:", error);
    return res.status(500).json({
      message: "Internal server error",
      error: error.message
    });
  }
};
