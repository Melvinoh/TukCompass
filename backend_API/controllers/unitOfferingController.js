import {UnitOffering} from "../modules/unitOffering.js"
import {UnitEnrollment} from "../modules/unitEnrollment.js"
import {Schedule} from "../modules/schedule.js"
import {ScheduleCourse} from "../modules/scheduleCourse.js"
import {sequelize} from "../config/sequelizeDB.js"

export const unitOfferingReg = async (req,res) => {

    const{lecturerID, unitID, academicYear, year, sem, schedules}= req.body

    const t = await sequelize.transaction()
    try {
        
        const[newOffering] = await UnitOffering.findOrCreate({
            where:{unitID,academicYear,sem},
            defaults:{lecturerID,year},
            transaction: t
        })
        for (const sched of schedules) {
            const newShedule = await Schedule.create({
                unitOfferingID: sched.unitOfferingID,
                day: sched.day,
                startTime: sched.startTime,
                endTime: sched.endTime,
                mode: sched.mode
            },{transaction: t})

            for (const courseID of sched.courseIDs) {
                const newSCheduleCourse = await ScheduleCourse.create({
                    courseID: courseID,
                    scheduleID: newShedule.scheduleID
                },{transaction: t})
            }
        }
        res.status(201).json({
            message:"unit offering added succefully",
            unitAdded:newOffering
        })

    } catch (error) {

        await t.rollback()
        console.error(error)
        res.status(500).json({
            message: "failed to add  offering ",
            error: error.message
        })
        
    }
    
}
