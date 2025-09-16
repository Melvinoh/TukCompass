
import { Unit } from "../../modules/Acdemics/units.js"
import { CourseUnit } from "../../modules/Acdemics/courseUnit.js"
import {sequelize} from "../../config/sequelizeDB.js"
import {Student} from "../../modules/Acdemics/students.js"

export const addCurriculum = async (req,res) =>{

    const{courseID, units } = req.body

    const t = await sequelize.transaction()
    const processedUnits =[];

    try {
        
        for (const unit of units) {

            const [newUnit] = await Unit.findOrCreate({
                where: { unitID: unit.unitID },
                defaults:{
                    unitName: unit.unitName,
                },
                transaction: t
            })

            const newCourseUnit = await CourseUnit.findOrCreate({
                where:{
                    courseID:courseID,
                    unitID: newUnit.unitID,
                    year: unit.Year,
                    sem: unit.Sem
                },
                transaction: t
            });

            processedUnits.push(newUnit);
        };

        await t.commit();
        res.status(201).json({
            message:`${courseID} curriculm units added succefully`,
            units: processedUnits
        });


    } catch (err) {

        await t.rollback();
        console.error("unit registration failed", err);
        res.status(500).json({
            message:"failed to add units and update curriculum",
            error: err.message
        });

    }

}


export const fetchUserCourseUnits = async (req, res) => {
  try {
    const userId = req.user.userID;
    if (!userId) {
      return res.status(400).json({ error: 'userID required (either as route param or authenticated user)' });
    }

    // 1) find student record to get courseID
    const student = await Student.findOne({ where: { studentID: userId } });
    if (!student || !student.courseID) {
      return res.status(404).json({ error: 'Student or course not found for given userID' });
    }
    const courseID = student.courseID;

    // 2) fetch courseUnits for that course, include the Unit model
    const courseUnits = await CourseUnit.findAll({
      where: { courseID },
      include: [
        {
          model: Unit,
          attributes: ['unitID', 'unitName', 'unitDescription']
        }
      ],
      attributes: ['courseUnitID', 'unitID', 'year', 'sem'],
      order: [['year', 'ASC'], ['sem', 'ASC'], [{ model: Unit }, 'unitName', 'ASC']]
    });

    console.log(`Fetched ${courseUnits} `);

    // 3) group by year -> sem
    const groupedMap = {}; // { [year]: { [sem]: [unitObj, ...] } }
    courseUnits.forEach(cu => {
        console.log(cu.toJSON())
      const year = Number(cu.year);
      const sem = Number(cu.sem);
      const unitObj = cu.units_tb
      console.log(unitObj)
        ? {
            unitID: cu.units_tb?.unitID || cu.unitID,   // notice: capital "U"
            unitName: cu.units_tb?.unitName || null,
            unitDescription: cu.units_tb?.unitDescription || null,
            courseUnitID: cu.courseUnitID
        }
        : { unitID: cu.unitID, courseUnitID: cu.courseUnitID };

      if (!groupedMap[year]) groupedMap[year] = {};
      if (!groupedMap[year][sem]) groupedMap[year][sem] = [];
      groupedMap[year][sem].push(unitObj);
    });

    // Convert map to a sorted array for nicer client consumption:
    const grouped = Object.keys(groupedMap)
      .map(y => Number(y))
      .sort((a, b) => a - b)
      .map(year => ({
        year,
        semesters: Object.keys(groupedMap[year])
          .map(s => Number(s))
          .sort((a, b) => a - b)
          .map(sem => ({ sem, units: groupedMap[year][sem] }))
      }));

    return res.json({ courseID, grouped });
  } catch (err) {
    console.error('getCourseUnitsForUser error:', err);
    return res.status(500).json({ error: err.message });
  }
};
