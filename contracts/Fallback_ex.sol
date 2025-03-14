// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Receive and Fallback Functions, special functions that receive funds automatically
contract Fallback_ex{
    
    uint256 public result = 0;

    // No calldata is specified
    receive() external payable { 
        result = 1;
    }

    // When callData is specified
    fallback() external payable {
        result = 2;
    }
}