import { Sequelize } from "sequelize";
import dotenv from "dotenv";

dotenv.config();

export const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASSWORD,
  {
    host: process.env.DB_HOST,
    dialect: "mysql",
    define:{
      freezeTableName : true,
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

  sequelize.sync({ alter: true }).then(() => {
    console.log("✅ DB synced");
  });

} catch (error) {
    console.log(JSON.stringify({ message: error}))
};

