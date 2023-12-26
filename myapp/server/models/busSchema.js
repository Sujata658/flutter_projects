const mongoose = require("mongoose");
const busSchema = new mongoose.Schema({
  bid: { type: String, required: true },
  name: { type: String, required: true },
  // number: { type: String, required: true },
  type: { type: String, required: true },
  direction: { type: String },
  route: { type: String, ref: "Route", required: true },
});

const Bus = mongoose.models.Bus || mongoose.model("Bus", busSchema);

module.exports = Bus;
