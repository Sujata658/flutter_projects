const mongoose = require("mongoose");

const routeSchema = new mongoose.Schema({
  name: { type: String, required: true },
  starting: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Stop",
    required: true,
  },
  start: { type: String },
  end: { type: String },
  ending: { type: mongoose.Schema.Types.ObjectId, ref: "Stop", required: true },
  // stops_list: [{ type: mongoose.Schema.Types.ObjectId, ref: "Stop" }],
  stops_list: [{ type: String }],
});

const Route = mongoose.models.Route || mongoose.model("Route", routeSchema);

module.exports = Route;
