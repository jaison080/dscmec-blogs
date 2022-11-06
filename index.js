const { spawn } = require("child_process");

function logEvery2Seconds(i) {
  setTimeout(() => {
    console.log("Infinite Loop Test n:", i);
    logEvery2Seconds(++i);
  }, 2000);
}

logEvery2Seconds(0);

let i = 0;
setInterval(() => {
  const child = spawn(`git pull --rebase origin master`, { shell: true });
  child.stdout.on("data", (data) => {
    console.log(`stdout: ${data}`);
  });

  child.stderr.on("data", (data) => {
    console.log(`stderr: ${data}`);
  });

  child.on("error", (error) => {
    console.log(`error: ${error.message}`);
  });

  child.on("close", (code) => {
    console.log(`child process exited with code ${code}`);
  });
}, 2000);
