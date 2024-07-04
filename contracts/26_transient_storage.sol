// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


interface ITEST {
    function val() external view returns (uint256);
    function get() external;
}

contract Callback {
    uint256 public val;

    fallback() external {
        val = ITEST(msg.sender).val();
    }

    function test(address target) external {
        ITEST(target).get();
    } 
}

contract TestStorage {
    uint256 public val;

    function test() public {
        val = 123;
        bytes memory b = "";
        msg.sender.call(b);
    }
}

