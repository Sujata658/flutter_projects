const Stop = require("../models/stopModels");
const express = require("express");
const router = express.Router();

router.post("/addstop", async (req, res) => {
  try {
    const { id, lat, long, name } = req.body;

    if (!lat || !long || !name || !id) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const newstop = new Stop({
      id,
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
router.get("/stopsList", async (req, res) => {
  try {
    const stops = await Stop.find();
    const stopsName = stops.map((stop) => stop.name);
    res.json({ stopsName });
  } catch (error) {
    console.error("Error fetching stops:", error);
    res.status(500).json({ error: "Failed to fetch stops" });
  }
});

router.get("/stops/:id", async (req, res) => {
  try {
    const stopId = req.params.id;
    console.log(stopId);

    const stop = await Stop.findOne({ id: stopId });

    if (!stop) {
      return res.status(404).json({ error: "Stop not found" });
    }

    console.log(stop);
    res.json({ stop });
  } catch (error) {
    console.error("Error fetching stop by ID:", error);
    res.status(500).json({ error: "Failed to fetch stop by ID" });
  }
});

router.put("/stop/:id", async (req, res) => {
  try {
    const { id, lat, long, name } = req.body;
    const stopId = req.params.id;

    if (!lat || !long || !name || !id) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const updatedstop = await Stop.findByIdAndUpdate(
      stopId,
      {
        id,
        lat,
        long,
        name,
      },
      { new: true }
    );

    if (!updatedstop) {
      return res.status(404).json({ error: "stop not found" });
    }

    res.json({ success: true, message: updatedstop });
  } catch (error) {
    console.error("Error updating stop:", error);
    res.status(500).json({ error: "Failed to update stop" });
  }
});

// Delete stop by ID
router.delete("/stop/:id", async (req, res) => {
  try {
    const stopId = req.params.id;

    const deletedstop = await Stop.findByIdAndDelete(stopId);

    if (!deletedstop) {
      return res.status(404).json({ error: "stop not found" });
    }

    res.json({ success: true, message: "stop deleted successfully" });
  } catch (error) {
    console.error("Error deleting stop:", error);
    res.status(500).json({ error: "Failed to delete stop" });
  }
});
module.exports = router;
