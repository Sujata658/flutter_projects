const Route = require("../models/routeModels");
const express = require("express");
const router = express.Router();
const { stopIdToStopName } = require("../routes/helper");

router.post("/addroute", async (req, res) => {
  try {
    const { id, name, start, end, stops_list } = req.body;

    if (!id || !name || !start || !end || !stops_list) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const newroute = new Route({
      id,
      name,
      start,
      end,
      stops_list,
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
    console.log(routeNames);
  } catch (error) {
    console.error("Error fetching routes:", error);
    res.status(500).json({ error: "Failed to fetch routes" });
  }
});
router.get("/routes/:id", async (req, res) => {
  try {
    const routeId = req.params.id;
    console.log(routeId);
    const route = await Route.findOne({ id: routeId });

    if (!route) {
      return res.status(404).json({ error: "Route not found" });
    }
    const stopsDataList = route.stops_list;
    console.log("stopss listtttt", route.start);

    // if (!Array.isArray(stopsDataList)) {
    //   console.error("Invalid stops_list data:", stops_list);
    //   return res.status(500).json({ error: "Invalid stops_list data" });
    // }
    const routeName = route.name;
    console.log("route name", routeName);

    const stopsData = await Promise.all(
      stopsDataList.map(async (stop) => {
        return await stopIdToStopName(stop);
      })
    );
    const startStop = await stopIdToStopName(route.start);
    const endStop = await stopIdToStopName(route.end);

    // console.log(route);
    res.json({ routeName, stopsData, startStop, endStop });
  } catch (error) {
    console.error("Error fetching route by ID:", error);
    res.status(500).json({ error: "Failed to fetch route by ID" });
  }
});

module.exports = router;
