const mongoose = require("mongoose");

const vehicleSchema = new mongoose.Schema({
    type: {
        type: String,
        required: true
    },
});