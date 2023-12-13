import { connectDB } from "@/utils/connectDB";
import routeModels from "@/models/routeModels";
import stopModels from "@/models/stopModels";
import busModels from "@/models/busModels";

export async function POST(req) {
  await connectDB();
  const { busId } = await req.json();
  //check if the busId exists
  const bus = await busModels.findById(busId).exec();
  if (!bus) {
    return Response.json({ error: "Bus not found" }, { status: 404 });
  }
  //mutate evey top and route from busid and send the response in the format of {name, number, type, direction, route: {name, starting, ending, stops: [{name, latitude, longitude}]}}

  const route = await routeModels.findById(bus.route).exec();

  const starting = await stopModels.findById(route.starting).exec();
  const ending = await stopModels.findById(route.ending).exec();
  const stops = [];
  for (let i = 0; i < route.stops.length; i++) {
    const stop = await stopModels.findById(route.stops[i]).exec();
    stops.push(stop);
  }
  const response = {
    name: bus.name,
    number: bus.number,
    type: bus.type,
    direction: bus.direction,
    route: {
      name: route.name,
      starting: starting,
      ending: ending,
      stops: stops,
    },
  };
  return Response.json(response);
}
