const Stop = require("../models/stopModels");
const express = require("express");
const router = express.Router();

router.post("/addStop", async (req, res) => {
  try {
    const { name, starting, ending, stops } = req.body;

    if (!name || !starting || !ending || !stops) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const newstop = new Stop({
      name,
      starting,
      ending,
      stops,
    });

    await newstop.save();

    res.json({ success: true, message: newstop });
  } catch (error) {
    console.error("Error creating stop:", error);
    res.status(500).json({ error: "Failed to send stop" });
  }
});

router.get("/stops", async (req, res) => {
  try {
    const stops = await Stop.find();
    res.json({ stops });
  } catch (error) {
    console.error("Error fetching stops:", error);
    res.status(500).json({ error: "Failed to fetch stops" });
  }
});

module.exports = router;
