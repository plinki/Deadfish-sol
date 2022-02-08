//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
//          __
//         /  ;
//     _.--"""-..   _.
//    /F         `-'  [
//   ]  ,    ,    ,    ;
//    '--L__J_.-"" ',_;
//        '-._J

/// @author plink(i) (https://github.com/plinki)
/// @title A Deadfish interpreter in Solidity
/// @dev Will possibly optimize
contract Deadfish {
    uint256 internal constant instructionLimit = 500;

    struct instance {
        int256 accumulator;
        int256[] plops;
    }

    mapping(address => instance) public instances;

    function instruct(uint256[] memory instructions) public returns (int256[] memory) {
        require(instructions.length > 1, "No instructions");
        require(instructions.length < instructionLimit, "Too many instructions");

        delete instances[msg.sender].plops;

        int256 current_accumulator = instances[msg.sender].accumulator;

        for (uint256 i = 0; i < instructions.length; ++i) {
            if (instructions[i] == 0x69) {
                current_accumulator += 1;
            }

            if (instructions[i] == 0x64) {
                current_accumulator -= 1;
            }

            if (instructions[i] == 0x73) {
                current_accumulator = current_accumulator ** 2;
            }

            if (instructions[i] == 0x6F) {
                instances[msg.sender].plops.push(current_accumulator);
            }

            if (current_accumulator == 256 || current_accumulator == -1) {
                current_accumulator = 0;
            }
        }

        return instances[msg.sender].plops;
    }

    function getPlops() public view returns (int256[] memory) {
        return instances[msg.sender].plops;
    }
}
