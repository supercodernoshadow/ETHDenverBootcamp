// SPDX-License-Identifier: UNLICENSED
import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity 0.8.17;

contract VolcanoCoin is Ownable {

    uint256 totalSupply = 10000;
    mapping(address => uint256) public balances;
    struct Payment{uint256 amt; address recpt;}
    mapping(address => Payment[]) public transfers;

    event SupplyChange(uint256 newSupply);
    event Transfer(uint256 amount, address recepiant);

     constructor() {
        balances[owner()] = totalSupply;
    }

    function tokenSupply() public view returns(uint256){
        return totalSupply;
    }

    function print() public onlyOwner {
        totalSupply += 1000;
        balances[owner()] += 1000;
        emit SupplyChange(totalSupply);
    }

    function checkBalance(address addy) public view returns(uint256){
        return balances[addy];
    }

    function transfer(uint256 amount, address recepiant) public{
        require(balances[msg.sender] >= amount,"Broke Boi");
        balances[msg.sender] -= amount;
        balances[recepiant] += amount;
        emit Transfer(amount, recepiant);
        recordPayment(msg.sender, recepiant, amount);
    }

    function viewPayments(address user) public view returns(Payment[] memory){
        return transfers[user];
    }

    function recordPayment(address sender, address recepiant, uint256 amount) public{
        transfers[sender].push(Payment({amt: amount, recpt: recepiant}));
    }

}