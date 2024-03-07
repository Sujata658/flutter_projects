const mongoose = require("mongoose");
const vehicleSchema = new mongoose.Schema({
  vid: { type: String, required: true },

  name: { type: String, required: true },
  // number: { type: String, required: true },
  type: { type: String, required: true },
  // directionType: {type:bool, required:true}
  //  true mean it has directio nlike tempo and goes round and round

  // false mean it doesn't go round it returns the same way
});

const Vehicle =
  mongoose.models.Vehicle || mongoose.model("Vehicle", vehicleSchema);

module.exports = Vehicle;
