import { connectDB } from "@/utils/connectDB";
import fareModels from "@/models/fareModels";
import busModels from "@/models/busModels";

export async function POST(req) {
  await connectDB();
  const { starting, ending, rate, bus } = await req.json();

  //handle every exceptions
  if (!starting) {
    return Response.json({ error: "starting is required" }, { status: 400 });
  }
  if (!ending) {
    return Response.json({ error: "ending is required" }, { status: 400 });
  }
  if (!rate) {
    return Response.json({ error: "rate is required" }, { status: 400 });
  }
  if (!bus) {
    return Response.json({ error: "bus is required" }, { status: 400 });
  }

  //check if the busId does not exists
  const busNotExists = await busModels.findOne({ _id: bus }).exec();
  if (!busNotExists) {
    return Response.json({ error: "Bus not found" }, { status: 404 });
  }
  //check if the bus already exists
  //   const busAlreadyExists = await busModels.findOne({ number, name }).exec();
  //   if (busAlreadyExists) {
  //     return Response.json({ error: "Bus already exists" }, { status: 400 });
  //   }
  //create the bus
  const fare = await fareModels.create({ starting, ending, rate, bus });
  return Response.json(fare);
}
