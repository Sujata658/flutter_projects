const mongoose = require("mongoose");

const stopSchema = new mongoose.Schema({
  id: { type: String, required: true },
  lat: { type: Number, required: true },
  long: { type: Number, required: true },
  name: { type: String, required: true },
});

const Stop = mongoose.models.Stop || mongoose.model("Stop", stopSchema);

module.exports = Stop;
