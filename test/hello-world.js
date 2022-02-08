const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Deadfish", function () {
    let deadfish;

 before(async function () {
    const Deadfish = await ethers.getContractFactory("Deadfish");
    deadfish = await Deadfish.deploy();
    await deadfish.deployed();
 });
  it("Deadfish hello world", async function () {

    cmdArray = []
    hello_world = "iisiiiisiiiiiiiioiiiiiiiiiiiiiiiiiiiiiiiiiiiiioiiiiiiiooiiiodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddodddddddddddddddddddddsddoddddddddoiiioddddddoddddddddo";

    for (let command of hello_world) {
        cmdArray.push(`0x${new Buffer.from(command).toString('hex')}`);
    }

    // gas reporter
    expect(await deadfish.instruct(cmdArray));

    const result = await deadfish.getPlops();
    let word;
    for (let code of result) {
        word += String.fromCharCode(code);
    }

    console.log(word);
  });
});
