// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract GmPortal {
    uint256 totalGms;

    struct Gmer {
        uint gmCount;
    }

    mapping (address => Gmer) gmers;

    constructor() {
        console.log("Hello, I'm a contract and I'm smart");
    }

    function gm() public {
        totalGms += 1;
        console.log("%s has said gm!", msg.sender);
        gmers[msg.sender].gmCount += 1;
    }

    function getTotalGms() public view returns (uint256) {
        console.log("We have %d people saying gm!", totalGms);
        return totalGms;
    }
}