const express = require("express");
const User = require("../models/userschema");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const cookieParser = require("cookieparser");
const Route = require("../models/routeModels");
const router = express.Router();
const Notification = require("../models/notificationSchema");
const Fare = require("../models/fareModels");
const Bus = require("../models/busSchema");

const Stop = require("../models/stopModels");

const { stopToId, busIdToBus, routeIdToroute } = require("../routes/helper");

router.post("/signup", (req, res) => {
  // console.log(req.body);
  const { name, phone, email, password, cpassword } = req.body;

  if (!name || !phone || !email || !password || !cpassword) {
    return res.status(422).json({ error: "Please fill all the fields" });
  }

  User.findOne({ email: email })
    .then((userExist) => {
      if (userExist) {
        return res.status(422).json({ error: "Email already exists" });
      }
      const user = new User({ name, phone, email, password, cpassword });
      user
        .save()
        .then(() => {
          res.status(201).json({ message: "User registered successfully" });
        })
        .catch((err) => res.status(500).json({ error: "Failed to register" }));
    })
    .catch((err) => {
      console.log(err);
    });
});

router.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body;
    // console.log(req.body)

    if (!email || !password) {
      return res.status(400).json({ error: "Please fill all the fields" });
    }

    const userLogin = await User.findOne({ email: email });
    // console.log(userLogin);

    if (userLogin) {
      const isMatch = await bcrypt.compare(password, userLogin.password);

      if (!isMatch) {
        res.status(400).json({ error: "Invalid credentials" });
      } else {
        const token = await userLogin.generateAuthToken();
        // console.log(token);

        res.cookie("jwtoken", token, {
          expires: new Date(Date.now() + 25892000000),
          httpOnly: true,
        });

        res.status(200).json({ message: "User logged in successfully" });
      }
    } else {
      res.status(400).json({ error: "Invalid credentials" });
    }
  } catch (err) {
    console.log(err);
  }
});

router.post("/search", async (req, res) => {
  try {
    let dir = 0;
    let { source, destination } = req.body;

    console.log(source, destination);

    if (!source || !destination) {
      return res.status(422).json({ error: "Please fill all the fields" });
    }
    // source = await stopToId(source);
    // destination = await stopToId(destination);

    const data = await Fare.find({
      starting: source,
      ending: destination,
    });

    // console.log(data);

    if (data.length === 0) {
      const data2 = await Fare.find({
        starting: destination,
        ending: source,
      });

      if (data2.length === 0) {
        console.log("No matching routes found");
        return res.status(422).json({ error: "No matching routes found" });
      } else {
        const responseData = data2.map(async (fare) => {
          const busId = fare.bus;
          const foundBus = await busIdToBus(busId);
          const routeId = foundBus.route;
          const foundRoute = await routeIdToroute(routeId);

          return {
            rate: fare.rate,
            bus: foundBus.name,
            route: foundRoute.name,
            routeId: routeId,
            busId: busId,
          };
        });

        // Wait for all promises in the responseData array to resolve
        const resolvedData = await Promise.all(responseData);
        console.log("no of found routes ", resolvedData.length);
        console.log("found routes", resolvedData);

        // Process the found routes as needed
        return res.status(200).json({
          message: "Matching routes found",
          data: resolvedData,
        });
      }
    }

    const responseData = data.map(async (fare) => {
      const busId = fare.bus;
      const foundBus = await busIdToBus(busId);
      const routeId = foundBus.route;
      const foundRoute = await routeIdToroute(routeId);

      return {
        rate: fare.rate,
        bus: foundBus.name,
        route: foundRoute.name,
        routeId: routeId,
        busId: busId,
      };
    });

    // Wait for all promises in the responseData array to resolve
    const resolvedData = await Promise.all(responseData);
    console.log("no of found routes ", resolvedData.length);
    console.log("found routes", resolvedData);

    // Process the found routes as needed
    return res.status(200).json({
      message: "Matching routes found",
      data: resolvedData,
    });
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
router.post("/searchByName", async (req, res) => {
  try {
    let dir = 0;
    let { source, destination } = req.body;

    console.log(source, destination);

    if (!source || !destination) {
      return res.status(422).json({ error: "Please fill all the fields" });
    }
    source = await stopToId(source);
    destination = await stopToId(destination);
    console.log("source and destination id", source, destination);

    const data = await Fare.find({
      starting: source,
      ending: destination,
    });

    // console.log(data);

    if (data.length === 0) {
      const data2 = await Fare.find({
        starting: destination,
        ending: source,
      });

      if (data2.length === 0) {
        console.log("No matching routes found");
        return res.status(422).json({ error: "No matching routes found" });
      } else {
        const responseData = data2.map(async (fare) => {
          const busId = fare.bus;
          const foundBus = await busIdToBus(busId);
          const routeId = foundBus.route;
          const foundRoute = await routeIdToroute(routeId);

          return {
            rate: fare.rate,
            bus: foundBus.name,
            route: foundRoute.name,
            routeId: routeId,
            busId: busId,
          };
        });

        // Wait for all promises in the responseData array to resolve
        const resolvedData = await Promise.all(responseData);
        console.log("no of found routes ", resolvedData.length);
        console.log("found routes", resolvedData);

        // Process the found routes as needed
        return res.status(200).json({
          message: "Matching routes found",
          data: resolvedData,
        });
      }
    }

    const responseData = data.map(async (fare) => {
      const busId = fare.bus;
      const foundBus = await busIdToBus(busId);
      const routeId = foundBus.route;
      const foundRoute = await routeIdToroute(routeId);

      return {
        rate: fare.rate,
        bus: foundBus.name,
        route: foundRoute.name,
        routeId: routeId,
        busId: busId,
      };
    });

    // Wait for all promises in the responseData array to resolve
    const resolvedData = await Promise.all(responseData);
    console.log("no of found routes ", resolvedData.length);
    console.log("found routes", resolvedData);

    // Process the found routes as needed
    return res.status(200).json({
      message: "Matching routes found",
      data: resolvedData,
    });
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
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

    res.json({ success: true, message: "newNotification" });
  } catch (error) {
    console.error("Error sending notification:", error);
    res.status(500).json({ error: "Failed to send notification" });
  }
});
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
