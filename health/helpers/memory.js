const si = require("systeminformation");

async function getMemInfo() {
    const mem = await si.mem();

    return {
        usageActive: parseFloat(((mem.active / mem.total) * 100).toFixed(2)),
        usageTotal: parseFloat(((mem.used / mem.total) * 100).toFixed(2)),
    };
}

module.exports = {getMemInfo};
