const express = require("express");
const path = require("path");
const bodyParser = require("body-parser");

const { spawn } = require("child_process");
const User = require("../models/userschema");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const Route = require("../models/routeModels");
const router = express.Router();
const Fare = require("../models/fareModels");

const { busIdToBus, routeIdToroute } = require("../routes/helper");

// Use bodyParser to parse incoming JSON data
router.use(bodyParser.json());

// POST endpoint to find the shortest path
router.post("/searchTry", async (req, res) => {
  // Extract source and destination from the request body

  try {
    let dir = 0;
    let { source, destination } = req.body;

    console.log(source, destination);

    if (!source || !destination) {
      return res.status(422).json({ error: "Please fill all the fields" });
    }
    // source = await stopToId(source);
    // destination = await stopToId(destination);

    const data = await Fare.find({
      starting: source,
      ending: destination,
    });

    if (data.length === 0) {
      console.log("no sidha direct rotue");
      const data2 = await Fare.find({
        starting: destination,
        ending: source,
      });

      if (data2.length === 0) {
        console.log("No matching routes found, now searching indrect routes");
        const pythonScriptPath = path.join(__dirname, "finalwithoutgraph.py");

        // Function to call the Python script
        const pythonProcess = spawn("python", [
          pythonScriptPath,
          source.toString(),
          destination.toString(),
        ]);

        let result = "";
        let error = "";

        pythonProcess.stdout.on("data", (data) => {
          result += data.toString();
        });

        pythonProcess.stderr.on("data", (data) => {
          error += data.toString();
        });

        pythonProcess.on("close", (code) => {
          console.log(`Python script exited with code ${code}`);

          if (code === 0) {
            try {
              // The result is already in string format, no need to parse
              res.status(200).json(result);
            } catch (parseError) {
              console.error(`Error parsing result: ${parseError}`);
              res
                .status(500)
                .json({ error: "Error parsing result from Python script" });
            }
          } else {
            console.error(`Python script error: ${error}`);
            res.status(500).json({ error: "Error running Python script" });
          }
        });

        // return res.status(422).json({ error: "No matching routes found" });
      } else {
        console.log("there is sidha direct");
        console.log("printing actual data", data2);
        const responseData = data2.map(async (fare) => {
          const busId = fare.bus;
          const foundBus = await busIdToBus(busId);
          const routeId = foundBus.route;
          const foundRoute = await routeIdToroute(routeId);
          console.log(foundRoute);
          //write code to get stops from the stop ids from foundRoute.stops_list
          return {
            rate: fare.rate,
            bus: foundBus.name,
            route: foundRoute.name,
            routeId: routeId,
            busId: busId,
          };
        });

        // Wait for all promises in the responseData array to resolve
        const resolvedData = await Promise.all(responseData);
        console.log("no of found routes ", resolvedData.length);
        console.log("found routes", resolvedData);

        // Process the found routes as needed
        return res.status(200).json({
          message: "Matching routes found 113",
          data: resolvedData,
        });
      }
    }

    const responseData = data.map(async (fare) => {
      const busId = fare.bus;
      const foundBus = await busIdToBus(busId);
      const routeId = foundBus.route;
      const foundRoute = await routeIdToroute(routeId);

      return {
        rate: fare.rate,
        bus: foundBus.name,
        route: foundRoute.name,
        routeId: routeId,
        busId: busId,
      };
    });

    // Wait for all promises in the responseData array to resolve
    const resolvedData = await Promise.all(responseData);
    console.log("no of found routes ", resolvedData.length);
    console.log("found routes", resolvedData);

    // Process the found routes as needed
    return res.status(200).json({
      message: "Matching routes found line 141",
      data: resolvedData,
    });
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: "Internal Server Error" });
  }

  // const { source, destination } = req.body;

  // Check if source and destination are provided
  // if (!source || !destination) {
  //   return res
  //     .status(400)
  //     .json({ error: "Missing source or destination in the request body" });
  // }

  // Get the absolute path to the Python script
  // const pythonScriptPath = path.join(__dirname, "finalwithoutgraph.py");

  // // Function to call the Python script
  // const pythonProcess = spawn("python", [
  //   pythonScriptPath,
  //   source.toString(),
  //   destination.toString(),
  // ]);

  // let result = "";
  // let error = "";

  // pythonProcess.stdout.on("data", (data) => {
  //   result += data.toString();
  // });

  // pythonProcess.stderr.on("data", (data) => {
  //   error += data.toString();
  // });

  // pythonProcess.on("close", (code) => {
  //   console.log(`Python script exited with code ${code}`);

  //   if (code === 0) {
  //     try {
  //       // The result is already in string format, no need to parse
  //       res.status(200).send(result);
  //     } catch (parseError) {
  //       console.error(`Error parsing result: ${parseError}`);
  //       res
  //         .status(500)
  //         .json({ error: "Error parsing result from Python script" });
  //     }
  //   } else {
  //     console.error(`Python script error: ${error}`);
  //     res.status(500).json({ error: "Error running Python script" });
  //   }
  // });
});

module.exports = router;
