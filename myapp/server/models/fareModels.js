const mongoose = require("mongoose");

const fareSchema = new mongoose.Schema({
  starting: {
    type: String,
    ref: "Stop",
    required: true,
  },
  ending: { type: String, ref: "Stop", required: true },
  rate: { type: Number, required: true },
  bus: { type: String, ref: "Bus", required: true },
});

const Fare = mongoose.models.Fare || mongoose.model("Fare", fareSchema);

module.exports = Fare;
