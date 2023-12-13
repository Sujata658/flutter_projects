import { connectDB } from "@/utils/connectDB";
import stopModels from "@/models/stopModels";
import routeModels from "@/models/routeModels";

export async function POST(req) {
  await connectDB();
  const { name, starting, ending, stops } = await req.json();

  // name is the name send by the user in string format, starting and ending are the object id of the stops and stops is the array of object id of stops
  //handle every exceptions
  if (!name) {
    return Response.json({ error: "Name is required" }, { status: 400 });
  }
  if (!starting) {
    return Response.json(
      { error: "Starting stop is required" },
      { status: 400 }
    );
  }
  if (!ending) {
    return Response.json({ error: "Ending stop is required" }, { status: 400 });
  }
  if (!stops) {
    return Response.json({ error: "Stops are required" }, { status: 400 });
  }
  if (stops.length < 2) {
    return Response.json(
      { error: "Atleast 2 stops are required" },
      { status: 400 }
    );
  }
  //check if the starting stop and ending stop exists
  const startingStop = await stopModels.findById(starting).exec();
  if (!startingStop) {
    return Response.json({ error: "Starting stop not found" }, { status: 404 });
  }
  const endingStop = await stopModels.findById(ending).exec();
  if (!endingStop) {
    return Response.json({ error: "Ending stop not found" }, { status: 404 });
  }
  //check if the stops exists
  for (let i = 0; i < stops.length; i++) {
    const stop = await stopModels.findById(stops[i]).exec();
    if (!stop) {
      return Response.json({ error: "Stop not found" }, { status: 404 });
    }
  }
  //check if the route already exists

  const checkRouteExists = await routeModels.findOne({ name }).exec();
  if (checkRouteExists) {
    return Response.json({ error: "Route already exists" }, { status: 400 });
  }
  //create the route
  const route = await routeModels.create({ name, starting, ending, stops });
  return Response.json(route);
}
