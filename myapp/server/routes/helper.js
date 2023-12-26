const Stop = require("../models/stopModels.js");
const route = require("../models/routeModels.js");

const stopToId = async (stopname) => {
  try {
    const foundStop = await Stop.findOne({ name: stopname })
      .select({ _id: 0, id: 1 })
      .lean();

    if (foundStop) {
      console.log("found stop's id from id ", foundStop);
      return foundStop.id;
    } else {
      console.error("no such stop line 12 at helper.js");
      // throw new Error("No such stop");
    }
  } catch (err) {
    console.log(err);
    throw new Error("Internal Server Error"); // or handle in a way appropriate for your application
  }
};

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
