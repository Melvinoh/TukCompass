import { Unit} from "../modules/units.js"
import {CourseUnit} from "../modules/courseUnit.js"
import {sequelize} from "../config/sequelizeDB.js"


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