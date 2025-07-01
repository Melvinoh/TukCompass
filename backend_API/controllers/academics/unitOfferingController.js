import { Unit } from "../../modules/Acdemics/units.js";
import { sequelize } from "../../config/sequelizeDB.js";
import { UnitOffering } from "../../modules/Acdemics/unitOffering.js";
import { Course } from "../../modules/Acdemics/course.js";
import { Schedule } from "../../modules/Acdemics/schedule.js";
import { ScheduleCourse } from "../../modules/Acdemics/scheduleCourse.js";  

export const unitOfferingReg = async (req, res) => {
  const { unitName, lecturerID, academicYear, sem, year, schedules } = req.body;
  const t = await sequelize.transaction();

  const unit = await Unit.findOne({where:{unitName},transaction: t})

  if(!unit){
       await t.rollback();
       return res.status(404).json({message:"unit not found"})
  }

  try {
    const [newOffering] = await UnitOffering.findOrCreate({
        where: {
            lecturerID,
            unitID: unit.unitID, 
            academicYear,
            year,
            sem,
        },
        transaction: t
    });

    for (const sched of schedules) {
      const courseNames = sched.courseNames;

      // Get courseIDs from names
      const courseRecords = await Course.findAll({
        where: { courseName: courseNames },
        transaction: t
      });

      if (!courseRecords.length) {
        throw new Error("No matching course(s) found");
      }

      const courseIDs = courseRecords.map(course => course.courseID);

      // Loop through time slots
      for (const slot of sched.timeSlots) {
        const [newSchedule] = await Schedule.findOrCreate({
            where: {
                unitOfferingID: newOffering.unitOfferingID,
                day: slot.day,
                startTime: slot.startTime,
                endTime: slot.endTime,
                mode: slot.room
            },
            transaction: t
        });

        // Link each course to this schedule
        for (const courseID of courseIDs) {
            await ScheduleCourse.findOrCreate({
                where: {
                    scheduleID: newSchedule.scheduleID,
                    courseID 
                },
                transaction: t
            });

        }
      }
    }

    await t.commit();

    res.status(201).json({
      message: "Unit offering added successfully",
      unitAdded: newOffering
    });

  } catch (error) {
    await t.rollback();
    console.error(error);
    res.status(500).json({
      message: "Failed to add unit offering",
      error: error.message
    });
  }
};
