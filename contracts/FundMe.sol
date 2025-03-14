// AIM:
// Get funds from the users
// Withdraw funds
// Set Minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConvertor} from "./PriceConvertor.sol";

error notOwner();

contract FundMe {
    // all the uint256 can use the library PriceConvertor 
    using PriceConvertor for uint256;

    // fund() :-> Get Funds from the user and setting the minimum funding value with it 
    // By adding the keyword payable we make the contract capable of holding value

    // Note:  First deploy the contract without sending any value then, while 
    // Calling the fund function pass the value required 

    // Gas Optimisation -> Constant and immutable addition
    // if then error(outside the contract) rather than require 
    uint256 constant MIN_USD = 5e18;
    address public immutable i_owner;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded; 

    
     
    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        // The calling uint256 is the first argument to the called library function
        require(msg.value.getConversionRate() >= MIN_USD, "didn't have enough eth");  // Allowing 1 Ether or more)
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }
    // require(bool condition) :-> 
    // -> reverts if the condition is not met - to be used for errors in inputs or external components.
    // what is a revert ? 
    // Undo any actions that have been done, and send the remaining gas back !!!


    function withdraw() public onlyOwner {
        // Only allow the owner to withdraw the funds
        // Two ways 1) require  2) modifier 
        // require(msg.sender == owner, "Must be owner to withdraw !!!");
        for(uint256 funderIndex = 0;funderIndex < funders.length;funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reseting the array <- Creating a new address array object
        funders = new address[](0);
        //It **creates a new dynamic array with zero elements** and assigns it to `funders`.  
    
        // Three ways to send eth from a contract
        //transfer <-  if fails then reverts 
        //   payable(msg.sender).transfer(address(this).balance);
        // //send <- if fails returns a bool false;
        // bool sendStatus = payable(msg.sender).send(address(this).balance);
        // require(sendStatus, "Couldn't send the funds ");

        //call
        (bool callStatus, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callStatus, "Call failed !!!");
    } 

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Must be owner !!!");
        // Gas Optimised
        if( msg.sender != i_owner ){
            revert notOwner();
        }
        _;   // After checking then execute the function         
    }

    // How will the contract handle the funds to the contract that aren't send via the fund() function 
    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
     }

}
// Getting the Global special variables 
// https://docs.soliditylang.org/en/v0.8.29/units-and-global-variables.html