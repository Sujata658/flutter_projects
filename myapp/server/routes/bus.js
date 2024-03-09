const Bus = require("../models/busSchema");
const express = require("express");
const router = express.Router();

router.post("/addBus", async (req, res) => {
  try {
    const { vehicleId, busId, isDirection, route, bus_list } = req.body;

    if (!vehicleId || !isDirection || !route || !busId) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const newBus = new Bus({
      vehicleId,
      busId,
      isDirection,
      route,
      bus_list,
    });

    await newBus.save();

    res.json({ success: true, message: newBus });
  } catch (error) {
    console.error("Error creating Bus:", error);
    res.status(500).json({ error: "Failed to send Bus" });
  }
});

router.get("/buses", async (req, res) => {
  try {
    const buses = await Bus.find();
    res.json({ buses });
  } catch (error) {
    console.error("Error fetching buses:", error);
    res.status(500).json({ error: "Failed to fetch buses" });
  }
});
// router.get("/buslist", async (req, res) => {
//   try {
//     const buses = await Bus.find();
//     const BusNames = buses.map((Bus) => Bus.name);
//     res.json({ BusNames });
//   } catch (error) {
//     console.error("Error fetching buses:", error);
//     res.status(500).json({ error: "Failed to fetch buses" });
//   }
// });

router.put("/bus/:id", async (req, res) => {
  try {
    const { vehicleId, busId, isDirection, route, bus_list } = req.body;
    const bud_id = req.params.id;

    if (!vehicleId || !isDirection || !route || !busId || !bus_list) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const updatedBus = await Bus.findByIdAndUpdate(
      bud_id,
      {
        vehicleId,
        busId,
        isDirection,
        route,
        bus_list,
      },
      { new: true }
    );

    if (!updatedBus) {
      return res.status(404).json({ error: "Bus not found" });
    }

    res.json({ success: true, message: updatedBus });
  } catch (error) {
    console.error("Error updating Bus:", error);
    res.status(500).json({ error: "Failed to update Bus" });
  }
});

// Delete bus by ID
router.delete("/bus/:id", async (req, res) => {
  try {
    const bud_id = req.params.id;

    const deletedBus = await Bus.findByIdAndDelete(bud_id);

    if (!deletedBus) {
      return res.status(404).json({ error: "Bus not found" });
    }

    res.json({ success: true, message: "Bus deleted successfully" });
  } catch (error) {
    console.error("Error deleting Bus:", error);
    res.status(500).json({ error: "Failed to delete Bus" });
  }
});

module.exports = router;
