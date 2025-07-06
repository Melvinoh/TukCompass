import { Sequelize } from "sequelize";
import dotenv from "dotenv";

dotenv.config();

export const sequelize = new Sequelize(
  process.env.MYSQLDATABASE,
  process.env.MYSQLUSER,
  process.env.MYSQLPASSWORD,
  {
    host: process.env.MYSQLHOST,
    port: process.env.MYSQLPORT,
    
    dialect: "mysql",
    define:{
      freezeTableName : true,
      timestamps: false
    }
  }
);

try {
  
  sequelize.authenticate().then(() => {
    console.log("✅ DB connection established");
  }
  ).catch((error) => {
    console.error("❌ Unable to connect to the database:", error);
  });

  sequelize.sync().then(() => {
    console.log("✅ DB synced");
  });

} catch (error) {
    console.log(JSON.stringify({ message: error}))
};

