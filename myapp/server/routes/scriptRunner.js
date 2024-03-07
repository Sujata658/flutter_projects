const express = require("express");
const router = express.Router();
const path = require("path");
const bodyParser = require("body-parser");

const { spawn } = require("child_process");

// Use bodyParser to parse incoming JSON data
router.use(bodyParser.json());

// POST endpoint to find the shortest path
router.post("/findShortestPath", (req, res) => {
  // Extract startStop and endStop from the request body
  const { startStop, endStop } = req.body;

  // Check if startStop and endStop are provided
  if (!startStop || !endStop) {
    return res
      .status(400)
      .json({ error: "Missing startStop or endStop in the request body" });
  }

  // Get the absolute path to the Python script
  const pythonScriptPath = path.join(__dirname, "finalwithoutgraph.py");

  // Function to call the Python script
  const pythonProcess = spawn("python", [
    pythonScriptPath,
    startStop.toString(),
    endStop.toString(),
  ]);

  let result = "";
  let error = "";

  pythonProcess.stdout.on("data", (data) => {
    result += data.toString();
  });

  pythonProcess.stderr.on("data", (data) => {
    error += data.toString();
  });

  pythonProcess.on("close", (code) => {
    console.log(`Python script exited with code ${code}`);

    if (code === 0) {
      try {
        // The result is already in string format, no need to parse
        res.status(200).send(result);
      } catch (parseError) {
        console.error(`Error parsing result: ${parseError}`);
        res
          .status(500)
          .json({ error: "Error parsing result from Python script" });
      }
    } else {
      console.error(`Python script error: ${error}`);
      res.status(500).json({ error: "Error running Python script" });
    }
  });
});

module.exports = router;
