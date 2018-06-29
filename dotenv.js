// Test file to tryout dotenv
// run file in terminal by: "node dotenv.js"
// set ENV value and run script in terminal by: "TEMP=123 node dotenv.js"
require('dotenv').config();

console.log("console log: " + process.env.TEMP);
