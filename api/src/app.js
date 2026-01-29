const express = require("express");
const vitalsRoutes = require("./modules/vitals/routes");

const app = express();
app.use(express.json());
app.use("/api", vitalsRoutes);

module.exports = app;
