import {Department} from "../modules/department.js";
import {Faculty} from "../modules/Faculty.js";
import {School} from "../modules/schools.js";
import {sequelize} from "../config/sequelizeDB.js";

export const adminPanel = async (req,res) =>{

    const {facultyID, facultyName, deanID, schools} = req.body;
    console.log(facultyID);

    if (!facultyID, !facultyName, !schools){
        res.status(400).json("all fields are required");
    }

    const t =  await sequelize.transaction();

    try {

        const existingFaculty = await Faculty.findByPk(facultyID, { transaction: t });
        if (existingFaculty) {
            await t.rollback();
            return res.status(400).json({ message: "Faculty ID already exists" });
        }

        const newFaculty = await Faculty.create({facultyID,facultyName}, {transaction: t});

        for(const school of schools) {

            const existingSchool = await School.findByPk(school.schoolID, { transaction: t });
            if (existingSchool) {
                await t.rollback();
                return res.status(400).json({ message: `School ID ${school.schoolID} already exists` });
            }

            const newSchool = await School.create({
                schoolID: school.schoolID,
                schoolName: school.schoolName,
                facultyID: newFaculty.facultyID
            },{transaction: t});

            for (const dept of school.departments) {
                const existingDept = await Department.findByPk(dept.departmentID, { transaction: t });
                if (existingDept) {
                    await t.rollback();
                    return res.status(400).json({ message: `Department ID ${dept.departmentID} already exists` });
                }

                const newDepartment = await Department.create({
                    departmentID: dept.departmentID,
                    departmentName: dept.departmentName,
                    schoolID: newSchool.schoolID
                }, {transaction: t});
            }
        };
        await t.commit();
        res.status(201).json({message: "faculty schools and its departments registration successful"});

    } catch (err) {
    
        await t.rollback();
        console.error(err);
        res.status(500).json({message :"could not update faculty heirachy something occured", error: err.message});
    };

};