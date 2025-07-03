import { Announcements } from "./announcment.js";
import { Events } from "./events.js";
import { User } from "../Users.js";
import { School } from "../Acdemics/schools.js";


Announcements.belongsTo(User, {foreignKey: 'createdBy',onDelete: 'CASCADE'});
User.hasMany(Announcements, {foreignKey: 'createdBy',onDelete: 'CASCADE',hooks: true});

Events.belongsTo(User, {foreignKey: 'createdBy',onDelete: 'CASCADE'});
User.hasMany(Events, {foreignKey: 'createdBy',onDelete: 'CASCADE',hooks: true}); 

Announcements.belongsTo(School, { foreignKey: 'schoolID' });
School.hasMany(Announcements, { foreignKey: 'schoolID', onDelete: 'SET NULL' })
