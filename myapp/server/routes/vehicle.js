const Vehicle = require("../models/vehicleSchema");
const Route = require("../models/routeModels");
const Bus = require("../models/busSchema");
const express = require("express");
const router = express.Router();

router.post("/addVehicle", async (req, res) => {
  try {
    const { vid, name, type } = req.body;

    if (!vid || !name || !type) {
      // console.log(req.body);
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

router.get("/BusesListByVehicleId/:id", async (req, res) => {
  try {
    const id = req.params.id;
    const vid = req.params.id;
    const busesList = await Bus.find({ vehicleId: id });
    let routesList = [];
    let routesName = [];
    let routeIdList = [];

    // Use Promise.all to wait for all Route.find() promises to resolve
    await Promise.all(
      busesList.map(async (bus) => {
        const routeId = bus.route;
        const route = await Route.findOne({ id: routeId }); // Use findOne instead of find
        if (route) {
          routesName.push(route.name);
          routesList.push(route);
          routeIdList.push(route.id);
        }
      })
    );

    // Send response after all routes are fetched
    res.json({
      message: "Data by routes",
      vehicle: vid,
      data: {
        routeId: routeIdList,
        routeNames: routesName,
        buses: busesList,
        routes: routesList,
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

module.exports = router;
