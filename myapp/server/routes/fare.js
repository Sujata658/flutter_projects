const Fare = require("../models/fareModels");
const express = require("express");
const router = express.Router();

router.post("/addFare", async (req, res) => {
  try {
    const { starting, ending, rate, bus } = req.body;

    if (!starting || !ending || !rate || !bus) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const newFare = new Fare({
      starting,
      ending,
      rate,
      bus,
    });

    await newFare.save();

    res.json({ success: true, message: newFare });
  } catch (error) {
    console.error("Error creating Fare:", error);
    res.status(500).json({ error: "Failed to send Fare" });
  }
});

router.get("/Fares", async (req, res) => {
  try {
    const Fares = await Fare.find();
    res.json({ Fares });
  } catch (error) {
    console.error("Error fetching Fares:", error);
    res.status(500).json({ error: "Failed to fetch Fares" });
  }
});

router.put("/fare/:id", async (req, res) => {
  try {
    const { starting, ending, rate, bus } = req.body;
    const fareId = req.params.id;

    if (!starting || !ending || !rate || !bus) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const updatedfare = await Fare.findByIdAndUpdate(
      fareId,
      {
        starting,
        ending,
        rate,
        bus,
      },
      { new: true }
    );

    if (!updatedfare) {
      return res.status(404).json({ error: "fare not found" });
    }

    res.json({ success: true, message: updatedfare });
  } catch (error) {
    console.error("Error updating fare:", error);
    res.status(500).json({ error: "Failed to update fare" });
  }
});

// Delete fare by ID
router.delete("/fare/:id", async (req, res) => {
  try {
    const fareId = req.params.id;

    const deletedfare = await Fare.findByIdAndDelete(fareId);

    if (!deletedfare) {
      return res.status(404).json({ error: "fare not found" });
    }

    res.json({ success: true, message: "fare deleted successfully" });
  } catch (error) {
    console.error("Error deleting fare:", error);
    res.status(500).json({ error: "Failed to delete fare" });
  }
});

module.exports = router;
