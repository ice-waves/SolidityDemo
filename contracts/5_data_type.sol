// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract DataType {
    uint8 x = 255; // 整型包含 intM 和uintM M最大为256， 数据溢出会导致Transaction revert
    bool a = false; // 服从短路规则，f(x)||g(y)，如果f(x)为true，则g(y)不会再执行，f(x)&&g(y)，如果f(x)为fasle，则g(y)不会再执行
    type Weight is uint128;
    Weight w = Weight.wrap(12); // 自定义类型，不可进行算数运算，想要进行运算需要使用unwrap 转换成普通数据类型进行计算

    address addr = 0x690B9A9E9aa1C9dB991C7721a92d351Db4FaC990; // 普通地址类型不可接受转账
    address payable addr_pay = payable(0x8306300ffd616049FD7e4b0354a64Da835c1A81C); // 可收款地址类型可以接受转账
    
    address payable addr_pay_second = payable(0x8306300ffd616049FD7e4b0354a64Da835c1A81C);
    address addr_second = addr_pay_second; // 可收款地址类型可以隐式转换成普通地址类型

    address addr_third = 0x8306300ffd616049FD7e4b0354a64Da835c1A81C;
    address payable addr_pay_third = payable(addr_third); // 普通地址类型必须显式转换成可收款地址类型

    // 地址类型成员变量,this代表当前合约
    function get_balance() public view returns(uint256) {
        return address(this).balance; //获取地址账户余额
    }

    function get_code() public view returns(bytes memory) {
        return address(this).code; // 获取合约代码
    }

    function get_codehash() public view returns (bytes32) {
        return address(this).codehash;
    }
    
    /**
    * transfer(uint256 amount): 向指定地址转账，不成功就抛出异常 revert（仅address payable可以使用）
    * send(uint256 amount): 与 transfer 函数类似，但是失败不会抛出异常，而是返回布尔值 （仅address payable可以使用）
    * call(...): 调用其他合约中的函数
    * delegatecall(...): 与 call 类似，但是使用当前合约的上下文来调用其他合约中的函数，修改的也是当前合约的数据存储
    * staticcall(...): 于 call 类似，但是不会改变链上状态
    * transfer与send的选择，非必要 一律选transfer
    */


    //字面值
    uint256 d1 = 256;
    uint256 d2 = .1+.9;
    uint256 d3 = 0xff;
    int256  d4 = 2e10;
    int256  d5 = -2e10;
    uint256 d6 = 1000_000;
    uint256 d7 = (2**800+1) - 2**800; // 有理数和整数子面值可以是任意精度,不会有精度损失的问题
    uint128 d8 = 2;
    // uint128 d9 = 2.5 + a + 3; // compile error 编译器会尝试将 2.5 转换成 uint128 类型。不过因为类型不匹配，编译器会报错

    function str_define() public pure returns (string memory)  {
        string memory s1 = "This is string";
        return s1;
    }

    // 枚举类型，可提升代码可读性
    enum ActionChoices { 
        GoLeft,     // 底层表示为 0 
        GoRight,    // 底层表示为 1
        GoUp,       // 底层表示为 2
        GoDown      // 底层表示为 3
    }

    ActionChoices choice;

    //枚举类型与整型的互相转换
    function enumToUint(ActionChoices c) public pure returns(uint) {
        return uint(c);
    }

    function uintToEnum(uint i) public pure returns(ActionChoices) {
        return ActionChoices(i);
    }
    
    function get_enum_max() public pure returns (uint8) {
        return uint8(type(ActionChoices).max);
    }

    function get_enum_min() public pure returns (uint8) {
        return uint8(type(ActionChoices).min);
    }

    // 因为ABI中没有枚举类型，所以这里的"getChoice() returns(ActionChoices)"函数签名
    // 会被自动转换成"getChoice() returns(uint8)"
    function getChoice() public view returns (ActionChoices) {
        return choice;
    }

    // 数组
    // 静态数组声明
    // function static_arr_define() public pure {
    //     uint[3] memory nftMem;
    //     uint256[3] storage nftStorage;
    //     nftMem = [uint(1), 2, 3];
    //     nftStorage = [uint256(1), 2, 3];
    // }

    // uint[] storage nftStoragex;
    // // 动态数组声明
    // function dynamic_arr_define() public pure {
    //     uint[] memory nftMem;
    //     nftMem = new uint[](3);
    //     nftStoragex = [uint(1), 2];
    // }

    uint[][] storageArr;
    uint[3][2] arr= [[uint(1), 2, 3], [uint(4), 5, 6]]; 
    function multi_arr_define() public {
        uint[3][2] memory arrMem;
        arrMem = [[uint(1), 2, 3], [uint(4), 5, 6]];

        uint n = 2;
        uint m = 3;
         for(uint i = 0; i < n; i++){
            storageArr.push(new uint[](m));
        }
    }

     //byte to string
    function byte_to_string() public pure returns (string memory) {
        bytes memory str = new bytes(10);
        string memory message = string(str);
        return message;
    }

    //string to byte, string 不可以进行下标访问，不可以访问length byte可以
    function string_to_byte() public pure returns (bytes memory) {
        string memory str = "hello world";
        bytes memory bytestr = bytes(str);
        return bytestr;
    }

    struct Book {
        string title; 
        uint price;
    }
    
    // 结构体初始化
    function init_struct() public pure returns (Book memory, Book memory){
        Book memory book1 = Book({
            title: "WTF",
            price: 25
        });
        Book memory book2 = Book("WTF", 25);
        console.log("title: %s", book2.title); // 获取结构体成员值
        return (book1, book2);
    }

    // mapping 定义，DataLocation只能为storage 且函数类型为private 或 internal
    function validDeclaration(mapping(address => uint) storage myMap) private {} 
    function validDeclaration2(mapping(address => uint) storage myMap) internal {} 
    // function validDeclaration(mapping(address => uint) storage myMap) public {} 

    uint immutable v;

    constructor () {
        v = 5;
    }
}