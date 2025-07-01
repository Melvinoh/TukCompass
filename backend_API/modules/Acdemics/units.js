import {sequelize} from '../../config/sequelizeDB.js';
import {DataTypes} from 'sequelize';

export const Unit = sequelize.define('units_tb', {
    unitID: {
        type: DataTypes.STRING(30),
        primaryKey: true,
    },
    unitName: {
        type: DataTypes.STRING(50),
        allowNull: false,
    },
    unitDescription: {
        type: DataTypes.STRING(255),
        allowNull: true,
    },
});
