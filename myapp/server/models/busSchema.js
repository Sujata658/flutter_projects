const mongoose = require("mongoose");
const busSchema = new mongoose.Schema({
  number: { type: String, required: true },
  // number: { type: String, required: true },
  vehicleId: { type: String, required: true },
  direction: { type: String, required: true },
  route: { type: String, required: true },
  // direction for tempo it will have  certain direction 1 for 1 direction(direction of stops)
  // 2 for opposite direction
  // if null, no direction or may write 0
});

const Bus = mongoose.models.Bus || mongoose.model("Bus", busSchema);

module.exports = Bus;
