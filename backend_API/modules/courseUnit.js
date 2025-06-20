import { sequelize } from "../config/sequelizeDB.js";
import { DataTypes } from "sequelize";
import { Course } from "./course.js"; 
import { Unit } from "./units.js";

export const CourseUnit = sequelize.define("course_unit_tb", {
  courseUnitID: {
    type: DataTypes.STRING(70),
    primaryKey: true,
    allowNull: false,
    defaultValue: DataTypes.UUIDV4
  },
  courseID: {
    type: DataTypes.STRING(30),
    references: {
      model: Course,
      key: "courseID",
    },
  },
  unitID: {
    type: DataTypes.STRING(30),
    references: {
      model: Unit,
      key: "unitID",
    },
  },
  year:{
    type: DataTypes.INTEGER(5),
    allowNull: false,
  },
  sem:{
    type: DataTypes.INTEGER(5),
    allowNull: false,
  }
});