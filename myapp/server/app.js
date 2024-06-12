const express = require("express");
const dotenv = require("dotenv");
const cors = require("cors");
const app = express();
const port = process.env.PORT || 5000;

dotenv.config({ path: "./config.env" });
app.use(cors());

require("./DB/connect");
app.use(express.json());
app.use(require("./routes/auth"));
app.use(require("./routes/bus"));
app.use(require("./routes/fare"));
app.use(require("./routes/stop"));
app.use(require("./routes/route"));
app.use(require("./routes/vehicle"));
app.use(require("./routes/scriptRunner"));
app.use(require("./routes/indivBus"));
// app.use(require("./routes/directandindirect"));
// app.use(require("./routes/searchFromRoutes"));

app.listen(port, () => {
  console.log(`server connected at port ${port}`);
});
