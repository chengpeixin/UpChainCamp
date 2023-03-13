// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "hardhat/console.sol";
contract Counter {
    uint public counter;
    address owner;
    constructor(){
        counter = 0;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You aren't the owner");
        _;
    }

    function add(uint256 x) public {
        counter += x;
    }

    function count() public onlyOwner{
        console.log("msg.sender address ->",msg.sender);
        console.log("owner address ->",owner);
        counter += 1;
    }

    function getCounter() public view returns(uint) {
        return counter;
    }
}
