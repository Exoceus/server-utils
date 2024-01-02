const si = require("systeminformation");
const os = require("os");
const {execute} = require("./execute.js");

async function getCpuInfo() {
    const avgLoads = os.loadavg(); // 0 = last min, 1 = last 5 mins, 2 = last 15 mins
    const processors = parseInt(await execute("nproc"));

    const loads = avgLoads.map((load) => parseFloat(((load / processors) * 100).toFixed(2))); // as a percentage

    const temps = await si.cpuTemperature();
    const speed = await si.cpuCurrentSpeed();

    return {
        load: loads,
        temperature: temps.main,
        speed: speed.avg,
    };
}

module.exports = {getCpuInfo};
