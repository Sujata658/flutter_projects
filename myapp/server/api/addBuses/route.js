import { connectDB } from "@/utils/connectDB";
import routeModels from "@/models/routeModels";
import busModels from "@/models/busModels";

export async function POST(req) {
  await connectDB();
  const { name, number, type, direction, route } = await req.json();

  //handle every exceptions
  if (!name) {
    return Response.json({ error: "Name is required" }, { status: 400 });
  }
  if (!number) {
    return Response.json({ error: "Number is required" }, { status: 400 });
  }
  if (!type) {
    return Response.json({ error: "Type is required" }, { status: 400 });
  }
  if (!direction) {
    return Response.json({ error: "Direction is required" }, { status: 400 });
  }
  if (!route) {
    return Response.json({ error: "Route is required" }, { status: 400 });
  }
  //check if the routeId does not exists
  const routeNotExists = await routeModels.findOne({ _id: route }).exec();
  if (!routeNotExists) {
    return Response.json({ error: "Route not found" }, { status: 404 });
  }
  //check if the bus already exists
  const busAlreadyExists = await busModels.findOne({ number, name }).exec();
  if (busAlreadyExists) {
    return Response.json({ error: "Bus already exists" }, { status: 400 });
  }
  //create the bus
  const bus = await busModels.create({ name, number, type, direction, route });
  return Response.json(bus);
}
