import { sequelize } from "../../config/sequelizeDB.js";
import { User } from "../Users.js";
import {Chats} from "./chats.js";
import{DataTypes} from 'sequelize'

export const ChatMember = sequelize.define("chatMembers_tb", {
    memberID: {
        type: DataTypes.STRING(45),
        primaryKey: true,
        defaultValue: DataTypes.UUIDV4
    },
    chatID: {
        type: DataTypes.STRING(45),
        allowNull: false,
        references: {
            model: Chats,
            key: "chatID"
        },
        onUpdate: "CASCADE",
        onDelete: "CASCADE"
    },
    userID: {
        type: DataTypes.STRING(30),
        allowNull: false,
        references: {
            model: User,
            key: "userID"
        },
        onUpdate: "CASCADE",
        onDelete: "CASCADE"
    },
    lastSeen:{
        type: DataTypes.DATE
    }
});