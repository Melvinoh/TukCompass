import { sequelize } from "../../config/sequelizeDB.js";
import { Chats } from "./chats.js";
import { User } from "../Users.js";
import{ DataTypes } from 'sequelize'

export const ChatMessage = sequelize.define("chatMessages_tb", {
    messageID: {
        type: DataTypes.STRING(45),
        primaryKey: true,
       defaultValue: DataTypes.UUIDV4
    },
    chatID: {
        type: DataTypes.STRING(45),
        allowNull: false,
        references: {
            model: Chats,
            key: "chatID",
        }
    },
    senderID: {
        type: DataTypes.STRING(30),
        allowNull: false,
        references: {
            model: User,
            key: "userID",
        }
    },
    messageContent: {
        type: DataTypes.TEXT,
        allowNull: false
    },
    mediaUrl: {
        type: DataTypes.STRING(255),
        allowNull: true
    },
    mediaType: {
        type: DataTypes.ENUM("image", "file", "video","none"),
        defaultValue: "none"
    },
    createdAt: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
});

