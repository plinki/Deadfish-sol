const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Deadfish", function () {
  it("Run Deadfish commands", async function () {
    const Deadfish = await ethers.getContractFactory("Deadfish");
    const deadfish = await Deadfish.deploy();
    await deadfish.deployed();

    cmdArray = []
    commands = "iisiiiisiiiiiiiioiiiiiiiiiiiiiiiiiiiiiiiiiiiiioiiiiiiiooiiiodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddodddddddddddddddddddddsddoddddddddoiiioddddddoddddddddo" // hello world

    // commands = "iissso";
    for (let c of commands) {
        cmdArray.push(c);
    }

    console.log(await deadfish.callStatic.instruct(cmdArray));
  });
});
