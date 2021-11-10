// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract GmPortal {
    uint256 totalGms;
    uint256 seed;

    // Solidity event
    event NewGm(address indexed from, uint256 timestamp, string message);

    struct Gm {
        address gmer;
        string message;
        uint256 timestamp;
    }

    Gm[] gms;

    mapping(address => uint256) public lastGmedAt;

    constructor() payable {
        console.log("Hello, I'm a contract and I'm smart");

        seed = (block.timestamp + block.difficulty) % 100;
    }

    function gm(string memory _message) public {
        require(
            lastGmedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );

        lastGmedAt[msg.sender] = block.timestamp;

        totalGms += 1;
        console.log("%s has said gm!", msg.sender);

        // Store gm data in the array
        gms.push(Gm(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        if (seed <= 50) {
        uint256 prizeAmount = 0.0000069 ether;
        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has..."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract");
        }

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