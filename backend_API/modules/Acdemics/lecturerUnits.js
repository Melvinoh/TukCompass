import { sequelize} from '../../config/sequelizeDB.js';
import { DataTypes } from 'sequelize';
import { Unit } from './units.js';
import { Lecturer } from './lecturers.js';

export const LecturerUnits = sequelize.define('LecturerUnits', {
  lecturerUnitID: {
    type: DataTypes.STRING(30),
    primaryKey: true,
    defaultValue: DataTypes.UUIDV4
  },
  lecturerID: {
    type: DataTypes.STRING(30),
    references: {
      model: Lecturer,
      key: 'lecturerID'
    }
  },
  unitID: {
    type: DataTypes.STRING(30),
    references: {
      model: Unit,
      key: 'unitID'
    }
  }
});
