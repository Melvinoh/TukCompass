import { Announcments } from "./announcment.js";
import { Events } from "./events.js";
import { User } from "../Users.js";
import { School } from "../Acdemics/schools.js";


Announcments.belongsTo(User, {foreignKey: 'createdBy',onDelete: 'CASCADE'});
User.hasMany(Announcments, {foreignKey: 'createdBy',onDelete: 'CASCADE',hooks: true});

Events.belongsTo(User, {foreignKey: 'createdBy',onDelete: 'CASCADE'});
User.hasMany(Events, {foreignKey: 'createdBy',onDelete: 'CASCADE',hooks: true}); 

Announcments.belongsTo(School, { foreignKey: 'schoolID' });
School.hasMany(Announcments, { foreignKey: 'schoolID', onDelete: 'SET NULL' })
