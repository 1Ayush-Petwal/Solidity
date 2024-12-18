
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {SimpleStorage2} from "./SimpleStorage2.sol";


// Inheritance using the keyword 'is'
contract addFiveStorage is SimpleStorage2{

    //Overriding of the function requires two major steps:
    //1. Making sure the overriding function is a virtual function ( virtual keyword in the function declaration)
    //2. Then while writing the override function in the child use the keyword 'override'

    function store(uint256 _newNum) public override {
        myfavNum = _newNum + 5;
    }
}
