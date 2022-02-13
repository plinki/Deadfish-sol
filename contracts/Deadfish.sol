//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.4;
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

    error NoInstructions();
    error TooManyInstructions();

    mapping(address => int256[]) plops;

    function instruct(uint256[] calldata instructions) external returns (int256[] memory) {
        if (instructions.length < 1) revert NoInstructions();
        if (instructions.length > 200) revert TooManyInstructions();
        delete plops[msg.sender];

        int256 current_accumulator = 0;

        unchecked {
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
                    plops[msg.sender].push(current_accumulator);
                }

                if (current_accumulator == 256 || current_accumulator == -1) {
                    current_accumulator = 0;
                }

            }
        }

        return plops[msg.sender];
    }

    function getPlops() external view returns (int256[] memory) {
        return plops[msg.sender];
    }
}
