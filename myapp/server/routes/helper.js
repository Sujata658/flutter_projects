const Stop = require("../models/stopModels.js");
const route = require("../models/routeModels.js");

const stopToId = async (stopname) => {
  try {
    const foundStop = await Stop.find({ name: stopname });

    if (foundStop.length > 0) {
      console.log("found stop's name from id ", foundStop[0].name);
      return foundStop[0].id;
    } else {
      console.error("no such stop line 12 at helper.js");
      // throw new Error("No such stop");
    }
  } catch (err) {
    console.log(err);
    throw new Error("Internal Server Error"); // or handle in a way appropriate for your application
  }
};
stopToId("Kumaripati");
console.log();

const routeToId = async (routename) => {
  try {
    const foundroute = await Route.find({ name: routename });

    if (foundroute) {
      console.log("found route's name from id ", foundroute.name);
      return foundroute.id;
    } else {
      console.error("no such route");
      res.status(400).json({ Err: "No such route" });
    }
  } catch (err) {
    console.log(err);
  }
};
module.exports = { routeToId, stopToId };
