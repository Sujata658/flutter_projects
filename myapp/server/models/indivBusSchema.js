const mongoose = require("mongoose");
const indivBusSchema = new mongoose.Schema({
  // number: { type: String, required: true },
  busId: { type: String, required: true },
  direction: { type: String, required: true },
  busNumber: { type: String, required: true },
  // direction for tempo it will have  certain direction 1 for 1 direction(direction of stops)
  // 2 for opposite direction
  // if null, no direction or may write 0
});

const IndivBus =
  mongoose.models.IndivBus || mongoose.model("IndivBus", indivBusSchema);

module.exports = IndivBus;
