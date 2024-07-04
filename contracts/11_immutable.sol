// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract Immutable {
    address public immutable My_Address;
    uint256 public immutable My_Uint;

    constructor(uint256 _myUint) {
        My_Address = msg.sender;
        My_Uint = _myUint;
    }
}