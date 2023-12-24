const Stop = require("../models/stopModels.js");
const route = require("../models/routeModels.js");

const stopToId = async (stopname) => {
  try {
    const foundStop = await Stop.find({ name: stopname });

    if (foundStop) {
      console.log("found stop's name from id ", foundStop.name);
      return foundStop.id;
    } else {
      console.error("no such stop");
      res.status(400).json({ Err: "No such stop" });
    }
  } catch (err) {
    console.log(err);
  }
};
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
module.exports = { routeToId };
