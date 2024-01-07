const Route = require("../models/routeModels");
const express = require("express");
const router = express.Router();

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

module.exports = router;
