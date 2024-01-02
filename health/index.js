require("dotenv").config();
const express = require("express");

const {getCpuInfo} = require("./helpers/cpu.js");
const {getMemInfo} = require("./helpers/memory.js");
const {getDiskInfo} = require("./helpers/disk.js");
const {execute} = require("./helpers/execute.js");

const PORT = process.env.PORT;
const app = express();

app.get("/", async (req, res) => {
    const machineName = await execute("hostname");
    res.json({machine: machineName, cpu: await getCpuInfo(), memory: await getMemInfo(), disk: await getDiskInfo()});
});

app.listen(PORT, () => console.log(`Example app is listening on port ${PORT}.`));
