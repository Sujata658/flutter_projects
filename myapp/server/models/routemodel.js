const mongoose = require("mongoose");

const routeSchema = new mongoose.Schema([
  {
    name: {
      type: String,
      required: true,
    },
    fare: {
      type: Number,
      required: true,
    },
    distance: {
      type: Number,
      required: true,
    },
    time: {
      type: Number,
      required: true,
    },
  },
]);

const Route = mongoose.model("ROUTE", routeSchema);
module.exports = Route;
