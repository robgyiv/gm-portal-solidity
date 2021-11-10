// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract GmPortal {
    uint256 totalGms;

    // Solidity event
    event NewGm(address indexed from, uint256 timestamp, string message);

    struct Gm {
        address gmer;
        string message;
        uint256 timestamp;
    }

    Gm[] gms;

    constructor() {
        console.log("Hello, I'm a contract and I'm smart");
    }

    function gm(string memory _message) public {
        totalGms += 1;
        console.log("%s has said gm!", msg.sender);

        // Store gm data in the array
        gms.push(Gm(msg.sender, _message, block.timestamp));

        emit NewGm(msg.sender, block.timestamp, _message);
    }

    // Return the gms struct array for the frontend
    function getAllGms() public view returns (Gm[] memory) {
        return gms;
    }

    function getTotalGms() public view returns (uint256) {
        console.log("We have %d people saying gm!", totalGms);
        return totalGms;
    }
}