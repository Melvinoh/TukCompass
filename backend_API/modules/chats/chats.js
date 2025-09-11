import { sequelize } from "../../config/sequelizeDB.js";
import { User } from "../Users.js";
import{DataTypes} from 'sequelize'

export const Chats = sequelize.define("chats_tb", {
  chatID: {
    type: DataTypes.STRING(45),
    primaryKey: true,
    defaultValue: DataTypes.UUIDV4
  },
  type: {
    type: DataTypes.ENUM('private', 'group'),
    defaultValue: "private"
  },
  chatName: {
    type: DataTypes.STRING(45),
  },
  chatAvatar: {
    type: DataTypes.STRING(255),
  },
},{timestamps: true});
