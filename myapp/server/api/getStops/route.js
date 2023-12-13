import { connectDB } from "@/utils/connectDB";
import stopModels from "@/models/stopModels";
export async function GET() {
  await connectDB();
  const stops = await stopModels.find({}).exec();

  //handle no stops
  if (!stops) {
    //this is the respone format Response.json({ name, email })
    return Response.json({ error: "No stops found" }, { status: 404 });
  }

  return Response.json(stops);
}
