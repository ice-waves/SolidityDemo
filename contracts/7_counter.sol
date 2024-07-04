// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract Counter {
    uint256 public count;
    
    function get() public view returns (uint256) {
        return count;
    }

    function inc() public {
        count+=1;
        console.log("count: ", count);
    }

    function dec() public {
        count-=1;
        console.log("count: ", count);
    }
}