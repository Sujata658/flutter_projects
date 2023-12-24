const mongoose = require("mongoose");

const routeSchema = new mongoose.Schema({
  name: { type: String, required: true },
  starting: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Stop",
    required: true,
  },
  ending: { type: mongoose.Schema.Types.ObjectId, ref: "Stop", required: true },
  stops: [{ type: mongoose.Schema.Types.ObjectId, ref: "Stop" }],
});

const Route = mongoose.models.Route || mongoose.model("Route", routeSchema);

module.exports = Route;
