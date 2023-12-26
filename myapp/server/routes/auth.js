// auth.js
const express = require("express");
const User = require("../models/userschema");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const cookieParser = require("cookieparser");
const Route = require("../models/routeModels");
const router = express.Router();
const Notification = require("../models/notificationSchema");
const Fare = require("../models/fareModels");
const Bus = require("../models/busSchema");

const { stopToId, busIdToBus, routeIdToroute } = require("../routes/helper");

router.post("/search", async (req, res) => {
  try {
    let { source, destination } = req.body;

    console.log(source, destination);

    if (!source || !destination) {
      return res.status(422).json({ error: "Please fill all the fields" });
    }
    source = await stopToId(source);
    destination = await stopToId(destination);

    const data = await Fare.find({
      starting: source,
      ending: destination,
    });

    console.log(data);

    if (data.length === 0) {
      console.log("No matching routes found");
      return res.status(422).json({ error: "No matching routes found" });
    }
    const busId = data[0].bus;
    const foundBus = await busIdToBus(busId);
    const routeId = foundBus.route;
    const foundRoute = await routeIdToroute(routeId);
    console.log("found route", foundRoute);
    const stops = foundRoute.stops_list;

    // Process the found routes as needed
    return res.status(200).json({
      message: "Matching routes found",
      data: data,
      rate: data[0].rate,
      bus: foundBus.name,
      route: foundRoute.name,
    });

    console.log("routes found");

    res.status(200).json({ message: "Matching routes found", data: data });
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// Endpoint to send a notification
router.post("/send-notification", async (req, res) => {
  try {
    const { title, description } = req.body;

    if (!title || !title) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const newNotification = new Notification({
      title,
      description,
    });

    await newNotification.save();

    // You can also send FCM notification here if needed

    res.json({ success: true, message: "newNotification" });
  } catch (error) {
    console.error("Error sending notification:", error);
    res.status(500).json({ error: "Failed to send notification" });
  }
});
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

    // You can also send FCM Fare here if needed

    res.json({ success: true, message: newFare });
  } catch (error) {
    console.error("Error sending Fare:", error);
    res.status(500).json({ error: "Failed to send Fare" });
  }
});
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

    // You can also send FCM Vehicle here if needed

    res.json({ success: true, message: newVehicle });
  } catch (error) {
    console.error("Error creating Vehicle:", error);
    res.status(500).json({ error: "Failed to send Vehicle" });
  }
});

// Endpoint to get all notifications
router.get("/addVehicle", async (req, res) => {
  try {
    const notifications = await Notification.find();
    res.json(notifications);
  } catch (error) {
    console.error("Error fetching notifications:", error);
    res.status(500).json({ error: "Failed to fetch notifications" });
  }
});

module.exports = router;
