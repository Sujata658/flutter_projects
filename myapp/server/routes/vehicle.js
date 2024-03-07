const Vehicle = require("../models/vehicleSchema");
const express = require("express");
const router = express.Router();

router.post("/addVehicle", async (req, res) => {
  try {
    const { vid, name, type } = req.body;

    if (!vid || !name || !type) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const newVehicle = new Vehicle({
      vid,
      name,
      type,
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
    const Vehiclees = await Vehicle.find();
    res.json({ Vehiclees });
  } catch (error) {
    console.error("Error fetching Vehiclees:", error);
    res.status(500).json({ error: "Failed to fetch Vehiclees" });
  }
});
router.get("/Vehiclelist", async (req, res) => {
  try {
    const Vehiclees = await Vehicle.find();
    const VehicleNames = Vehiclees.map((Vehicle) => Vehicle.name);
    res.json({ VehicleNames });
  } catch (error) {
    console.error("Error fetching Vehiclees:", error);
    res.status(500).json({ error: "Failed to fetch Vehiclees" });
  }
});

router.put("/vehicle/:id", async (req, res) => {
  try {
    const { vid, name, type } = req.body;
    const vehicleId = req.params.id;

    if (!vid || !name || !type) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const updatedvehicle = await Vehicle.findByIdAndUpdate(
      vehicleId,
      {
        vid,
        name,
        type,
      },
      { new: true }
    );

    if (!updatedvehicle) {
      return res.status(404).json({ error: "vehicle not found" });
    }

    res.json({ success: true, message: updatedvehicle });
  } catch (error) {
    console.error("Error updating vehicle:", error);
    res.status(500).json({ error: "Failed to update vehicle" });
  }
});

// Delete vehicle by ID
router.delete("/vehicle/:id", async (req, res) => {
  try {
    const vehicleId = req.params.id;

    const deletedvehicle = await Vehicle.findByIdAndDelete(vehicleId);

    if (!deletedvehicle) {
      return res.status(404).json({ error: "vehicle not found" });
    }

    res.json({ success: true, message: "vehicle deleted successfully" });
  } catch (error) {
    console.error("Error deleting vehicle:", error);
    res.status(500).json({ error: "Failed to delete vehicle" });
  }
});

module.exports = router;
