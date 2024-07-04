// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

// Using up all of the gas that you send causes your transaction to fail.
// State changes are undone.
// Gas spent are not refunded.
contract Gas {
    uint256 public i = 0;
    function forever() public {
        while(true) {
            i+=1;
        }
    }
}