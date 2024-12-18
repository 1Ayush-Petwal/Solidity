//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


//Importing specific contract form a File (much like react)
import {SimpleStorage2} from "./SimpleStorage2.sol";

contract StorageFactory2{

    //Note: The versions of two interacting contracts are using should be compatible
    // Then on deploying the contract that interact the compiler, if the contracts are compatible 
    // then the compiler is switched to the most optimal compiler for interaction 

    // Solidity follows the OOPS Paradigm
    // SimpleStorage2 public st;

    SimpleStorage2[] public listSimpleStorage;
    function createSimpleStorageCont() public{
        SimpleStorage2 st = new SimpleStorage2();
        listSimpleStorage.push(st);
    }

    // There are two major components while interaction of two contracts
    // Address
    // Contract Interface => (ABI - (Application Binary Interface) faciltites this Interface)
    // ABI - (techinally a lie, you just need the function selector) 

    function sfStore(uint256 _simpleStorageIndex,uint256 _simpleStorageNumber) public{
        //The compiler provides us with the ABI
        SimpleStorage2 newst = listSimpleStorage[_simpleStorageIndex];
        newst.store(_simpleStorageNumber);
    }

    // Getting the number stored in any of the storageContracts in the array

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        SimpleStorage2 getst = listSimpleStorage[_simpleStorageIndex];
        return getst.retrieve();
    }
}