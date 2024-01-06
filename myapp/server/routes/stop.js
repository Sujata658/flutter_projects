const Stop = require("../models/stopModels");
const express = require("express");
const router = express.Router();

router.post("/addstop", async (req, res) => {
  try {
    const { lat, long, name } = req.body;

    if (!lat || !long || !name) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const newstop = new Stop({
      lat,
      long,
      name,
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
