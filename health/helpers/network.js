const si = require('systeminformation');

async function getNetworkInfo() {
    const networks = await si.networkStats();

    const interfaces = networks.map(interface => { return { name: interface.iface, down: interface.rx_sec, up: interface.tx_sec } }
    );

    // console.log(networks)

    return {
        interfaces: interfaces
    }
}

module.exports = { getNetworkInfo };
