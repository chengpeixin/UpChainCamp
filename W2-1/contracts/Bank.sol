// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "hardhat/console.sol";
/*
1. 通过Metamask向Bank合约转账ETH
2. 在Bank合约记录每个地址转账金额
3. 编写Bank合约withdraw(),实现提取出所有的ETH
*/
contract Bank {
    address public owner;
    mapping(address => uint) public records;
    constructor(){
        owner = msg.sender;
    }
    modifier onlyOwner() {
        require( msg.sender == owner, "not owner");
        _;
    }

    // 向合约转账
    function transderToContract() external payable{
        payable(address(this)).transfer(msg.value);
    }

    // 给外部账户转账
    function transderToAddress(address payable toAddress) public payable onlyOwner{
        toAddress.transfer(msg.value);
    }

    function getThis() external view returns(address){
        return address(this);
    }

    function getBalance() external view returns(uint){
        return address(this).balance;
    }

    // 将转账储存
    receive() external payable {
        records[msg.sender] += msg.value;
    }

    fallback() external payable {}

    // 取出所有eth
    function withdraw() public {
        uint balance = address(this).balance;
        payable(owner).transfer(balance);
    }
}
