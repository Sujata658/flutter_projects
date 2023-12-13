import mongoose from "mongoose";

const fareSchema = new mongoose.Schema({
  starting: { type: mongoose.Schema.Types.ObjectId, ref: 'Stop', required: true },
  ending: { type: mongoose.Schema.Types.ObjectId, ref: 'Stop', required: true },
  rate: { type: Number, required: true },
  bus: { type: mongoose.Schema.Types.ObjectId, ref: 'Bus', required: true }
});

const Fare = mongoose.models.Fare || mongoose.model("Fare", fareSchema);

export default Fare;
