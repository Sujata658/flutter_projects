const mongoose = require("mongoose");
const DB = process.env.DB;

mongoose
  .connect(DB)
  .then(() => {
    console.log("database connection successful");
  })
  .catch((err) => console.log(err));
