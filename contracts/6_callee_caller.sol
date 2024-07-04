// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract Callee {
    event FunctionCalled(string);

    function foo() external payable {
        emit FunctionCalled("this is foo");
    }

    receive() external payable {  
        emit FunctionCalled("this is receive");
    }

    fallback() external payable { 
        emit FunctionCalled("this is fallback");
    }
}


contract Caller {
    address payable callee;
    constructor() payable  {
        callee = payable(address(new Callee()));
    }

    function transferReceive() external {
        callee.transfer(1);
    }

    function sendReceive() external {
        bool success = callee.send(1);
        require(success, "Fail to send Ether");
    }

      // 触发 foo 函数
    function callFoo() external {
        (bool success, bytes memory data) = callee.call{value: 1}(
            abi.encodeWithSignature("foo()")
        );
        console.log(string(data));
        require(success, "Failed to send Ether");
    }

    // 触发 fallback 函数，因为 funcNotExist() 在 Callee 没有定义
    function callFallback() external {
        (bool success, bytes memory data) = callee.call{value: 1}(
            abi.encodeWithSignature("funcNotExist()")
        );
        console.log(string(data));
        require(success, "Failed to send Ether");
    }

}