import { sequelize } from "../../config/sequelizeDB.js";
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
    videoUrl:{
        type: DataTypes.STRING
    },
    link: {
        type: DataTypes.STRING
    },
    contentType:{
        type: DataTypes.ENUM('video', 'link','pdf','assignment','past_papers'),
    },

    uploadedAt: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    },
    PdfUrl: {
        type: DataTypes.STRING
    },
    fileName: {
        type: DataTypes.STRING(100)
    }
});

