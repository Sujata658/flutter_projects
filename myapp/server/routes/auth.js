// auth.js
const express = require("express");
const User = require("../models/userschema");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const cookieParser = require("cookieparser");
const Route = require("../models/routeModels");
const router = express.Router();

const { stopToId } = require("../routes/helper");

// ... (other code)

router.post("/search", async (req, res) => {
  try {
    let { source, destination } = req.body;

    console.log(source, destination);

    if (!source || !destination) {
      return res.status(422).json({ error: "Please fill all the fields" });
    }

    console.log("here at line 80");
    source = await stopToId(source);
    destination = await stopToId(destination);
    console.log("id of searched stops", source, destination);

    const data = await Route.find({
      stops_list: { $all: [source, destination] },
    }).select("name");

    if (data.length === 0) {
      console.log("No matching routes found");
      return res.status(422).json({ error: "No matching routes found" });
    }

    console.log("routes found");

    res.status(200).json({ message: "Matching routes found", data: data });
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

module.exports = router;
