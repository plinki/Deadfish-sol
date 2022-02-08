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

    function instruct(string[] memory instructions) public returns (int256[] memory) {
        require(instructions.length > 1, "No instructions");
        require(instructions.length < instructionLimit, "Too many instructions");

        instances[msg.sender].accumulator = 0;
        delete instances[msg.sender].plops;

        int256 current_accumulator = instances[msg.sender].accumulator;
        for (uint256 i = 0; i < instructions.length; ++i) {
            if (parse(instructions[i]) == parse("i")) {
               current_accumulator += 1;
            }

            if (parse(instructions[i]) == parse("d")) {
                current_accumulator -= 1;
            }

            if (parse(instructions[i]) == parse("s")) {
                current_accumulator = current_accumulator ** 2;
            }

            if (parse(instructions[i]) == parse("o")) {
                instances[msg.sender].plops.push(current_accumulator);
            }

            if (current_accumulator == 256 || current_accumulator == -1) {
                current_accumulator = 0;
            }
        }

        return (instances[msg.sender].plops);
    }

    function parse(string memory instruction) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(instruction));
    }

    function getPlops() public view returns (int256[] memory) {
        return instances[msg.sender].plops;
    }
}
