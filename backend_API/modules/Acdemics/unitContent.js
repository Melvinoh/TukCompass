import { sequelize } from "../../config/sequelizeDB.js";
import { DataTypes } from "sequelize";
import { Unit } from "./units.js";

export const UnitContent = sequelize.define("unitContent_tb", {
    contentID: {
        type: DataTypes.STRING(40),
        primaryKey: true,
        defaultValue: DataTypes.UUIDV4
    },
    unitID: {
        type: DataTypes.STRING(40),
        references: { 
            model: Unit,
            key: "unitID" 
        }
    },
    pdfURL: {
        type: DataTypes.STRING
    },
    fileName: {
        type: DataTypes.STRING(100)
    },
    type: {
        type: DataTypes.ENUM( 'assignment','unit_Outline','unnit_PDF')
    },
    uploadedBy: {
        type: DataTypes.STRING(40)
    },
    uploadDate: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
});
