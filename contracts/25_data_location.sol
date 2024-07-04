// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract DataLocation {
    uint256[] public arr;
    mapping(uint256 => address) map;

    struct MyStruct {
        uint256 foo;
    }

    mapping(uint256 => MyStruct) myStructs;

    function _f(uint256[] storage _arr, mapping(uint256 => address) storage _map, MyStruct storage _myStruct) internal {
        // do something with storage variables
    }

    function f() public {
        // call _f with state variables
        _f(arr, map, myStructs[1]);

        // get a struct from a mapping
        MyStruct storage myStruct = myStructs[1];
        console.log(myStruct.foo);
        // create a struct in memory
        MyStruct memory myMemStruct = MyStruct(0);
        console.log(myMemStruct.foo);
    }

    function g(uint256[] memory _arr) public returns (uint256[] memory) {
        // do something with memory array
    }

    function h(uint256[] calldata _arr) external {
        // do something with calldata array
    }
}