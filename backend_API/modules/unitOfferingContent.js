import { sequelize } from "../config/sequelizeDB.js";
import { DataTypes } from "sequelize";
import { UnitOffering } from "./unitOffering.js";

export const UnitOfferingContent = sequelize.define("unitOfferingContent_tb", {
    offeringContentID: {
        type: DataTypes.STRING(40),
        primaryKey: true,
        defaultValue: DataTypes.UUIDV4
    },
    unitOfferingID: {
        type: DataTypes.STRING(40),
        references: { 
            model: UnitOffering,
            key: "unitOfferingID"
        }
    },
    videoURL:{
        DataTypes.STRING(100)
    },
    link: {
        DataTypes.STRING(100)
    },
    description: {
        DataTypes.TEXT
    },
    uploadedAt: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
});
