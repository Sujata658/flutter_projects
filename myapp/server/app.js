const express = require("express");
const dotenv = require("dotenv");
const app = express();
const port = process.env.PORT || 5000;

dotenv.config({ path: "./config.env" });

require("./DB/connect");
app.use(express.json());
app.use(require('./routes/auth'));
app.use(require('./routes/bus'));
app.use(require('./routes/fare'));
app.use(require('./routes/stop'));
app.use(require('./routes/route'));


app.listen(port, () => {
  console.log(`server connected at port ${port}`);
});
