const Route = require("../models/routeModels");
const express = require("express");
const router = express.Router();

const { stopIdToStopName } = require("../routes/helper.js");

router.post("/addroute", async (req, res) => {
  try {
    const { name, starting, ending, stops } = req.body;

    if (!name || !starting || !ending || !stops) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const newroute = new Route({
      name,
      starting,
      ending,
      routes,
    });

    await newroute.save();

    res.json({ success: true, message: newroute });
  } catch (error) {
    console.error("Error creating route:", error);
    res.status(500).json({ error: "Failed to send route" });
  }
});

router.get("/routes", async (req, res) => {
  try {
    const routes = await Route.find();
    res.json({ routes });
  } catch (error) {
    console.error("Error fetching routes:", error);
    res.status(500).json({ error: "Failed to fetch routes" });
  }
});
router.get("/routeslist", async (req, res) => {
  try {
    const routes = await Route.find();
    const routeNames = routes.map((route) => route.name);
    res.json({ routeNames });
  } catch (error) {
    console.error("Error fetching routes:", error);
    res.status(500).json({ error: "Failed to fetch routes" });
  }
});

// router.get("/routes/:id", async (req, res) => {
//   try {
//     const routeId = req.params.id;
//     console.log(routeId);
//     const route = await Route.findOne({ id: routeId });
//     const stops_list = route.stops_list;
//     const stopsData = await Promise.all(
//       stops_list.map(async (stop) => {
//         return await stopIdToStop(stop);
//       })
//     );

//     if (!route) {
//       return res.status(404).json({ error: "Route not found" });
//     }
//     console.log(route);
//     res.json({ route, stopsData });
//   } catch (error) {
//     console.error("Error fetching route by ID:", error);
//     res.status(500).json({ error: "Failed to fetch route by ID" });
//   }
// });

router.get("/routes/:id", async (req, res) => {
  try {
    const routeId = req.params.id;
    console.log(routeId);
    const route = await Route.findOne({ id: routeId });

    // console.log("Route:", route);

    if (!route) {
      return res.status(404).json({ error: "Route not found" });
    }
    const stopsDataList = route.stops_list;
    console.log("stopss listtttt", route.start);

    // if (!Array.isArray(stopsDataList)) {
    //   console.error("Invalid stops_list data:", stops_list);
    //   return res.status(500).json({ error: "Invalid stops_list data" });
    // }

    const stopsData = await Promise.all(
      stopsDataList.map(async (stop) => {
        return await stopIdToStopName(stop);
      })
    );
    const startStop = await stopIdToStopName(route.start);
    console.log(route.start);
    const endStop = await stopIdToStopName(route.end);

    // console.log(route);
    res.json({ route, stopsData, startStop, endStop });
  } catch (error) {
    console.error("Error fetching route by ID:", error);
    res.status(500).json({ error: "Failed to fetch route by ID" });
  }
});

module.exports = router;
