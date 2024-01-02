const execute = async (command) => {
    return new Promise((resolve, reject) => {
        const exec = require("child_process").exec;
        exec(command, function (error, stdout, stderr) {
            if (error) {
                reject(error);
                return;
            }
            if (stderr) {
                reject(stderr);
                return;
            } else {
                resolve(stdout.trim());
            }
        });
    });
};

module.exports = {execute};
