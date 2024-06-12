const IndivBus = require("../models/indivBusSchema");
const express = require("express");
const router = express.Router();

router.post("/addindivBus", async (req, res) => {
  try {
    const { busId, direction, busNumber } = req.body;

    if (!busId || !direction || !busNumber) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const newindivBus = new IndivBus({
      busId,
      direction,
      busNumber,
    });

    await newindivBus.save();

    res.json({ success: true, message: newindivBus });
  } catch (error) {
    console.error("Error creating indivBus:", error);
    res.status(500).json({ error: "Failed to send indivBus" });
  }
});

router.get("/indivbuses", async (req, res) => {
  try {
    const indivbuses = await IndivBus.find();
    res.json({ indivbuses });
  } catch (error) {
    console.error("Error fetching indivbuses:", error);
    res.status(500).json({ error: "Failed to fetch indivbuses" });
  }
});
// router.get("/indivbuslist", async (req, res) => {
//   try {
//     const indivbuses = await indivBus.find();
//     const indivBusNames = indivbuses.map((indivBus) => indivBus.name);
//     res.json({ indivBusNames });
//   } catch (error) {
//     console.error("Error fetching indivbuses:", error);
//     res.status(500).json({ error: "Failed to fetch indivbuses" });
//   }
// });

router.put("/indivbus/:id", async (req, res) => {
  try {
    const { busId, direction, busNumber } = req.body;
    const bud_id = req.params.id;

    if (!busId || !direction || !busNumber) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const updatedindivBus = await IndivBus.findByIdAndUpdate(
      bud_id,
      {
        busId,
        direction,
        busNumber,
      },
      { new: true }
    );

    if (!updatedindivBus) {
      return res.status(404).json({ error: "indivBus not found" });
    }

    res.json({ success: true, message: updatedindivBus });
  } catch (error) {
    console.error("Error updating indivBus:", error);
    res.status(500).json({ error: "Failed to update indivBus" });
  }
});

// Delete indivbus by ID
router.delete("/indivbus/:id", async (req, res) => {
  try {
    const bud_id = req.params.id;

    const deletedindivBus = await IndivBus.findByIdAndDelete(bud_id);

    if (!deletedindivBus) {
      return res.status(404).json({ error: "indivBus not found" });
    }

    res.json({ success: true, message: "indivBus deleted successfully" });
  } catch (error) {
    console.error("Error deleting indivBus:", error);
    res.status(500).json({ error: "Failed to delete indivBus" });
  }
});

module.exports = router;
