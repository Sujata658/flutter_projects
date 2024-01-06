const Bus = require("../models/busSchema");
const express = require("express");
const router = express.Router();

router.post("/addVehicle", async (req, res) => {
  try {
    const { bid, name, type, direction, route } = req.body;

    if (!bid || !name || !type || !direction || !route) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const newVehicle = new Bus({
      bid,
      name,
      type,
      direction,
      route,
    });

    await newVehicle.save();

    res.json({ success: true, message: newVehicle });
  } catch (error) {
    console.error("Error creating Vehicle:", error);
    res.status(500).json({ error: "Failed to send Vehicle" });
  }
});

router.get("/vehicles", async (req, res) => {
  try {
    const vehicles = await Bus.find();
    res.json({ vehicles });
  } catch (error) {
    console.error("Error fetching vehicles:", error);
    res.status(500).json({ error: "Failed to fetch vehicles" });
  }
});

module.exports = router;
