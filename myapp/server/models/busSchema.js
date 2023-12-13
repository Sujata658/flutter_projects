import mongoose from "mongoose";

const busSchema = new mongoose.Schema({
  name: { type: String, required: true },
  // number: { type: String, required: true },
  type: { type: String, required: true },
  direction: { type: String },
  route: { type: mongoose.Schema.Types.ObjectId, ref: "Route", required: true },
});

const Bus = mongoose.models.Bus || mongoose.model("Bus", busSchema);

export default Bus;
