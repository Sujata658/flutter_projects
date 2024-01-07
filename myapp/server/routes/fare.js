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

module.exports = router;
