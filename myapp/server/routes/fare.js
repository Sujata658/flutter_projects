const express = require("express");
const path = require("path");
const bodyParser = require("body-parser");
const { spawn } = require("child_process");

const router = express.Router();

// Use bodyParser to parse incoming JSON data
router.use(bodyParser.json());

// POST endpoint to run Python script
router.post("/run-python-script", async (req, res) => {
  // Extract data from the request body
  const { source, destination } = req.body;

  if (!source || !destination) {
    return res.status(422).json({ error: "Please fill all the fields" });
  }

  // Specify the path to your Python script
  const pythonScriptPath = path.join(
    __dirname,
    "path/to/your/python/script.py"
  );

  // Function to call the Python script
  const pythonProcess = spawn("python", [
    pythonScriptPath,
    source.toString(),
    destination.toString(),
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
        console.log("Python script result:", result);
        res.status(200).json({ data: result });
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
