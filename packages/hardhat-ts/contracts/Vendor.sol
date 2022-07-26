pragma solidity >=0.8.0 <0.9.0;
// SPDX-License-Identifier: MIT

import '@openzeppelin/contracts/access/Ownable.sol';
import './YourToken.sol';

contract Vendor is Ownable {
  uint256 public constant tokensPerEth = 100;
  YourToken public yourToken;
  event BuyTokens(address buyer, uint256 amountOfEth, uint256 amountOfTokens);

  constructor(address tokenAddress) public {
    yourToken = YourToken(tokenAddress);
  }

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable {
    uint256 amount = msg.value * tokensPerEth;
    yourToken.transfer(msg.sender, amount);
    emit BuyTokens(msg.sender, msg.value, amount);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH

  function withdraw(uint256 amount) public onlyOwner {
    (bool os, ) = payable(msg.sender).call{value: amount}('');
  }

  // ToDo: create a sellTokens() function:
  //users has to call approvw()
  function sellTokens(uint256 amount) public {
    uint256 ethAmount = (amount / tokensPerEth) * 10000;
    yourToken.transferFrom(msg.sender, address(this), amount); //transferring to the vendor
    (bool os, ) = payable(msg.sender).call{value: ethAmount / 10000}(''); // transferring to the user
  }

  function vendorContractaddress() public view returns (address) {
    return address(this);
  }
}
