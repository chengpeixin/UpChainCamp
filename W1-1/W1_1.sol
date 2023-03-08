pragma solidity ^0.8.18;

contract Counter {
    uint256 public counter;

    constructor() {
        counter = 0;
    }

    function add (uint256 x) public {
        counter+=x;
    }

    function getResult () public view returns(uint256) {
        return counter;
    }
}

// 交易hash