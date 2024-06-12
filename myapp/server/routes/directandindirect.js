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
const { stopIdToStopName, stopIdToLatLong } = require("../routes/helper");

const { busIdToBus, routeIdToroute } = require("../routes/helper");

// Use bodyParser to parse incoming JSON data
router.use(bodyParser.json());

// POST endpoint to find the shortest path
router.post("/search", async (req, res) => {
  let source1;
  let destination1;
  // Extract source and destination from the request body
  let { source, destination } = req.body;

  try {
    let resultArray = [];
    let dir = 0;

    console.log(typeof source, destination);
    source1 = parseInt(source);
    destination1 = parseInt(destination);
    console.log(typeof source1);

    if (!source || !destination) {
      return res.status(422).json({ error: "Please fill all the fields" });
    }
    const data = await Fare.find({
      starting: source,
      ending: destination,
    });
    if (data.length === 0) {
      const data2 = await Fare.find({
        starting: destination,
        ending: source,
      });

      if (data2.length === 0) {
        console.log("opposite direction also not found, no direct path");
      } else {
        console.log("printing actual data opposite direction", data2);
        const responseData = data2.map(async (fare) => {
          const busId = fare.bus;
          const foundBus = await busIdToBus(busId);
          const routeId = foundBus.route;
          const foundRoute = await routeIdToroute(routeId);
          console.log("100", foundRoute);
          stopsDataList = foundRoute.stops_list;
          console.log("stopsdatalist", stopsDataList);

          const finalList = stopsDataList.slice(destination1 - 1, source1);
          const reversedlist = finalList.reverse();
          console.log("reversed list", reversedlist);

          const latlongData = await Promise.all(
            reversedlist.map(async (stop) => {
              // console.log("lat long data", stopIdToLatLong(stop));
              return await stopIdToLatLong(stop);
              // Reverse the array before returning
            })
          );

          //   write code to get stops from the stop ids from foundRoute.stops_list
          return {
            rate: fare.rate,
            routeId: routeId,
            stops_list: reversedlist,
            busId: busId,
            lat_long: latlongData,
            flag: "direct",
          };
        });

        console.log("resp data 61", responseData);

        // Wait for all promises in the responseData array to resolve
        const resolvedData = await Promise.all(responseData);
        console.log("no of found routes ", resolvedData.length);
        console.log("found routes", resolvedData);
        const direct = "direct";

        // Process the found routes as needed
        resolvedData.map((data) => {
          resultArray.push(data);
        });

        return res.status(200).json({
          message: "Matching routes found 113",
          data: resolvedData,
        });
      }
    } else {
      // if direct route found ra sidhhaa
      console.log("printing actual data sidha direction", data);
      const responseData = data.map(async (fare) => {
        const busId = fare.bus;
        const foundBus = await busIdToBus(busId);
        const routeId = foundBus.route;
        const foundRoute = await routeIdToroute(routeId);
        console.log("100", foundRoute);
        stopsDataList = foundRoute.stops_list;
        console.log(stopsDataList);
        console.log("sorucea nd dest", source);

        const finalList = stopsDataList.slice(source1 - 1, destination1);

        console.log(finalList);

        const latlongData = await Promise.all(
          finalList.map(async (stop) => {
            // console.log("lat long data", stopIdToLatLong(stop));
            return await stopIdToLatLong(stop);
          })
        );

        //   write code to get stops from the stop ids from foundRoute.stops_list
        return {
          rate: fare.rate,
          routeId: routeId,
          stops_list: finalList,
          busId: busId,
          lat_long: latlongData,
          flag: "direct",
        };
      });

      console.log("resp data 61", responseData);

      // Wait for all promises in the responseData array to resolve
      const resolvedData = await Promise.all(responseData);
      console.log("no of found routes ", resolvedData.length);
      console.log("found routes", resolvedData);
      const direct = "direct";

      // Process the found routes as needed
      resolvedData.map((data) => {
        resultArray.push(data);
      });
      console.log("line 72", resultArray);
      console.log("resolved ata line 75", resolvedData);
      return res.status(200).json({
        message: "Matching routes found 113",
        data: resolvedData,
      });
    }

    console.log("searching for indirect");

    // console.log("No matching routes found, now searching indrect routes");
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

    pythonProcess.on("close", async (code) => {
      console.log(`Python script exited with code ${code}`);

      if (code === 0) {
        try {
          // The result is already in string format, no need to parse
          const parsedResult = JSON.parse(result);
          console.log("indirect result", parsedResult);
          let stops_list = parsedResult.shortest_path;
          // console.log(stops_list);

          const latlongData = await Promise.all(
            stops_list.map(async (stop) => {
              // console.log("lat long data", stopIdToLatLong(stop));
              return await stopIdToLatLong(stop);
              // Reverse the array before returning
            })
          );

          const temp = {
            "message": "Matching routes found",
            "data":
            [
            {
              flag: "indirect",

              //   result,
              stops_list: parsedResult.shortest_path,
              routes: parsedResult.routes,
              unique_routes: parsedResult.unique_routes,
              change_point: parsedResult.change_point,
              shortest_distance: parsedResult.shortest_distance,
              lat_long: latlongData,
              stops_name: parsedResult.stops_names
            },
          ]};
          // resultArray.push(temp);
          // console.log(parsedResult);

          res.status(200).json(temp);
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
    // console.log("indirect result", result);

    // return res.status(422).json({ errorf: "No matching routes found" });
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

module.exports = router;
