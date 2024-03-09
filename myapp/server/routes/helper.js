const Stop = require("../models/stopModels.js");
const route = require("../models/routeModels.js");
const Bus = require("../models/busSchema.js");

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
const stopToCoordinates = async (stop_id) => {
  try {
    const foundStop = await Stop.findOne({ id: stop_id }).select({ _id: 0 });
    console.log("found stop for coordinates line 28", foundStop);

    if (foundStop) {
      console.log("found lat long", foundStop.lat, foundStop.long);
      return { lat: foundStop.lat, long: foundStop.long };
    } else {
      console.error("no such stop found in line 34");
      // Handle the case when stop is not found
      return { lat: 0, long: 0 }; // or throw an error, depending on your requirement
    }
  } catch (err) {
    console.log(err);
    // Handle other errors, e.g., return a default value or throw an error
    return { lat: 0, long: 0 };
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
      // res.status(400).json({ Err: "No such route" });
    }
  } catch (err) {
    console.log(err);
  }
};

const busIdToBus = async (busId) => {
  try {
    console.log("busid", busId);
    const foundbus = await Bus.findOne({ busId: busId });

    if (foundbus) {
      console.log("found bus's  from id ", foundbus);
      return foundbus;
    } else {
      console.error("no such bus");
      // res.status(400).json({ Err: "No such bus" });
    }
  } catch (err) {
    console.log(err);
  }
};
const routeIdToroute = async (routeId) => {
  try {
    console.log("routeid", routeId);
    const foundroute = await route.findOne({ id: routeId }).select({ _id: 0 });

    if (foundroute) {
      console.log("found route's  from id ", foundroute);
      return foundroute;
    } else {
      console.error("no such route");
      // res.status(400).json({ Err: "No such route" });
    }
  } catch (err) {
    console.log(err);
  }
};
const stopIdToStop = async (stopId) => {
  try {
    console.log("routeid", stopId);
    const foundstop = await stop.findOne({ id: stopId }).select({ _id: 0 });

    if (foundstop) {
      console.log("found stop's  from id ", foundstop);
      return foundstop;
    } else {
      console.error("no such stop");
    }
  } catch (err) {
    console.log(err);
  }
};
// const stopIdToStopName = async (stopId) => {
//   try {
//     const foundstop = await Stop.findOne({ id: stopId }).select({ _id: 0 });

//     if (foundstop) {
//       return foundstop.name;
//     } else {
//       console.error("no such stop line 111");
//     }
//   } catch (err) {
//     console.log(err);
//   }
// };

const stopIdToStopName = async (stopId) => {
  try {
    console.log(stopId);
    const foundstop = await Stop.findOne({ id: stopId }).select({ _id: 0 });
    console.log(foundstop);
    if (foundstop) {
      return foundstop.name;
    } else {
      console.error("no such stop");
      // res.status(400).json({ Err: "No such stop" });
    }
  } catch (err) {
    console.log(err);
  }
};
const stopIdToLatLong = async (stopId) => {
  try {
    // console.log(stopId);
    const foundstop = await Stop.findOne({ id: stopId }).select({ _id: 0 });
    // console.log(foundstop);
    if (foundstop) {
      const coordinates = { lat: foundstop.lat, long: foundstop.long };
      return coordinates;
    } else {
      console.error("no such stop");
      // res.status(400).json({ Err: "No such stop" });
    }
  } catch (err) {
    console.log(err);
  }
};

module.exports = {
  routeToId,
  stopToId,
  busIdToBus,
  routeIdToroute,
  stopIdToStop,
  stopIdToStopName,
  stopIdToLatLong,
};
