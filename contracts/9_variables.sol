// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract Variables {
    string public text = "Hello";
    uint256 public num = 123;

    function doSometing() public view {
        uint256 i = 45;
        uint256 timestamp = block.timestamp;
        address sender = msg.sender;
        console.log(i, timestamp, sender);
    }
}