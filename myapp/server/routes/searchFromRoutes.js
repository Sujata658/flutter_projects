const { Router } = require("express");
const router = Router();
const path = require("path");

const { spawn } = require("child_process");

const express = require("express");
const User = require("../models/userschema");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const cookieParser = require("cookieparser");
const Route = require("../models/routeModels");
const Notification = require("../models/notificationSchema");
const Vehicle = require("../models/vehicleSchema");
const Fare = require("../models/fareModels");
const Bus = require("../models/busSchema");

const {
  stopToId,
  busIdToBus,
  routeIdToroute,
  routeIdTorouteName,
  stopIdToLatLong,
  stopIdToStopName,
} = require("../routes/helper"); // Adjust the path

router.post("/search", async (req, res) => {
  try {
    let { source, destination } = req.body;
    if (!source || !destination) {
      return res.status(422).json({ error: "Please fill all the fields" });
    }

    // Call your function to convert stops to IDs
    source = parseInt(source);
    destination = parseInt(destination);

    console.log("source and destination id", source, destination);

    const routes = await Route.find({
      stops_list: { $all: [source, destination] },
    });
    // console.log("routes list", routes);
    console.log("routes length", routes.length);
    if (routes.length === 0) {
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
            let two_route = parsedResult.two_routes;

            const routes_list = await Promise.all(
              two_route.map(async (route) => {
                console.log(route);

                const name = await routeIdTorouteName(route);
                console.log(typeof name);
                return name;
              })
            );
            changePoint = parsedResult.change_point;
            const changeStop = await stopIdToStopName(changePoint);

            console.log("routes list ", routes_list);

            const temp = [
              {
                flag: "indirect",

                //   result,
                rate: "0",
                // routes: parsedResult.routes,
                routeId: parsedResult.two_routes,
                change_point: changeStop,
                route: routes_list,
                shortest_path: parsedResult.shortest_path,

                shortest_distance: parsedResult.shortest_distance,
                lat_long: latlongData,
              },
            ];
            // resultArray.push(temp);
            // console.log(parsedResult);

            res
              .status(200)
              .json({ message: "Matching routes for indirect", data: temp });
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
      const sourceIndex = routes[0].stops_list.indexOf(source); //checking for only one assuming all are in same direction
      const destIndex = routes[0].stops_list.indexOf(destination);

      const dircounter = sourceIndex < destIndex ? 1 : -1;
      console.log("directio ncounter", dircounter);
      if (dircounter === 1) {
        // 1 means sulto direction

        const responseData = routes.map(async (route) => {
          const stopsDataList = route.stops_list;
          const sourceIndex = stopsDataList.indexOf(source); //checking for only one assuming all are in same direction
          const destIndex = stopsDataList.indexOf(destination);
          console.log(stopsDataList);
          const finalList = stopsDataList.slice(sourceIndex, destIndex + 1);
          console.log(finalList);
          const fare = await Fare.find({
            starting: source,
            ending: destination,
          });
          console.log("fare", fare);
          let rate = 0;
          let busId = "0";

          console.log("new rate", rate);

          const foundBus = await Bus.findOne({ route: route.id });
          if (foundBus) {
            busId = foundBus.busId;
          }
          //   const busId = foundBus.map(async (buses) => {
          //     return buses.busId;
          //   });
          //   console.log("foundbus", foundBus.busId);
          const latlongData = await Promise.all(
            finalList.map(async (stop) => {
              return await stopIdToLatLong(stop);
            })
          );
          fare.map((fares) => {
            console.log("checing 81", fares.bus, busId);
            if (fares.bus === busId) {
              console.log("fare found");

              rate = fares.rate;
            } else {
              rate = 0;
            }
          });
          //write code to get stops from the stop ids from foundRoute.stops_list
          return {
            flag: "direct",
            rate: rate,
            route: route.name,
            routeId: route.id,
            busId: busId,
            stopsList: finalList,
            latlong: latlongData,
          };
        });
        const resolvedData = await Promise.all(responseData);
        return res.status(200).json({
          message: "Matching routes, found",
          data: resolvedData,
        });
      } else {
        // 1 means sulto direction

        const responseData = routes.map(async (route) => {
          const stopsDataList = route.stops_list;
          stopsDataList.reverse();
          const sourceIndex = stopsDataList.indexOf(source); //checking for only one assuming all are in same direction
          const destIndex = stopsDataList.indexOf(destination);
          console.log(stopsDataList);
          const finalList = stopsDataList.slice(sourceIndex, destIndex + 1);
          console.log("final list", finalList);
          const fare = await Fare.find({
            starting: source,
            ending: destination,
          });
          console.log("fare", fare);
          let rate = 0;
          let busId = "0";

          console.log("new rate", rate);

          const foundBus = await Bus.findOne({ route: route.id });
          if (foundBus) {
            busId = foundBus.busId;
          }
          //   const busId = foundBus.map(async (buses) => {
          //     return buses.busId;
          //   });
          //   console.log("foundbus", foundBus.busId);
          const latlongData = await Promise.all(
            finalList.map(async (stop) => {
              return await stopIdToLatLong(stop);
            })
          );
          fare.map((fares) => {
            console.log("checing 81", fares.bus, busId);
            if (fares.bus === busId) {
              console.log("fare found");

              rate = fares.rate;
            } else {
              rate = 0;
            }
          });
          //write code to get stops from the stop ids from foundRoute.stops_list
          return {
            flag: "direct",
            rate: rate,
            route: route.name,
            routeId: route.id,
            busId: busId,
            stopsList: finalList,
            latlong: latlongData,
          };
        });
        const resolvedData = await Promise.all(responseData);
        return res.status(200).json({
          message: "Matching routes, found",
          data: resolvedData,
        });
      }
    }
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

module.exports = router;