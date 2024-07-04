// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

/**
 * @title Owner
 * @dev Set & change owner
 */
contract Owner {
   
    struct Identity {
        address addr;
        string name;
    }

    enum State {
        HasOwner,
        NoOwner
    }

    Identity private owner;
    State private state;

    // event for EVM logging
    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    event OwnerRemove(address indexed oldOwner);

    // modifier to check if caller is owner
    modifier isOwner() {
        // If the first argument of 'require' evaluates to 'false', execution terminates and all
        // changes to the state and to Ether balances are reverted.
        // This used to consume all gas in old EVM versions, but not anymore.
        // It is often a good idea to use 'require' to check if functions are called correctly.
        // As a second argument, you can also provide an explanation about what went wrong.
        require(msg.sender == owner.addr, "Caller is not owner");
        _;
    }

    /**
     * @dev Set contract deployer as owner
     */
    constructor(string memory name) {
        console.log("Owner contract deployed by:", msg.sender);
        owner.addr = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        owner.name = name;
        state = State.HasOwner;
        emit OwnerSet(address(0), owner.addr);
    }

    /**
     * @dev Change owner
     * @param addr address of new owner
     * @param name name of new owner
     */
    function changeOwner(address addr, string calldata name) public isOwner {
        owner.addr = msg.sender;
        owner.name = name;
        emit OwnerSet(owner.addr, addr);
    }
    
    /**
     * @dev Remove owner
     */
    function removeOwner() public isOwner {
        emit OwnerRemove(owner.addr);
        delete owner;
        state = State.NoOwner;
    }


    /**
     * @dev Return owner address 
     * @return address of owner
     */
    function getOwner() external view returns (address, string memory) {
        return (owner.addr, owner.name);
    }

    /**
     @dev Return owner state
     */
    function getState() external view returns (State) {
        return state;
    }
} 