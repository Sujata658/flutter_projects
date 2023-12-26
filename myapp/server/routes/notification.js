const express = require("express");
const router = express.Router();
const Notification = require("../models/notification");

// Endpoint to send a notification
router.post("/send-notification", async (req, res) => {
  try {
    const { title, body } = req.body;

    if (!body || !title) {
      return res.status(400).json({ error: "Missing required parameters" });
    }

    const newNotification = new Notification({
      title,
      body,
    });

    await newNotification.save();

    // You can also send FCM notification here if needed

    res.json({ success: true, message: "newNotification" });
  } catch (error) {
    console.error("Error sending notification:", error);
    res.status(500).json({ error: "Failed to send notification" });
  }
});

// Endpoint to get all notifications
router.get("/notifications", async (req, res) => {
  try {
    const notifications = await Notification.find();
    res.json(notifications);
  } catch (error) {
    console.error("Error fetching notifications:", error);
    res.status(500).json({ error: "Failed to fetch notifications" });
  }
});

module.exports = router;
