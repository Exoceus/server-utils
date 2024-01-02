const si = require("systeminformation");

async function getDiskInfo() {
    const disks = await si.disksIO();
    const fileSystems = await si.fsSize();

    return {
        readSpeed: disks.rIO_sec,
        writeSpeed: disks.wIO_sec,
        usage: fileSystems.map((fileSystem) => {
            return {
                fs: fileSystem.fs,
                usage: fileSystem.use,
                mount: fileSystem.mount,
                availableGB: parseFloat((fileSystem.available * 10 ** -9).toFixed(2)),
            };
        }),
    };
}

module.exports = {getDiskInfo};
