const express = require("express");
const dotenv = require("dotenv");
const app = express();
const port = process.env.PORT || 5000;

dotenv.config({ path: "./config.env" });

require("./DB/connect");
app.use(express.json());
app.use(require('./routes/auth'));


app.listen(port, () => {
  console.log(`server connected at port ${port}`);
});
