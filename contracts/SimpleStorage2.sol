//when we compile our contract it compiles down to 
// EVM compatible byte code 


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

//Contract are nothing but Classes IN OOPS Programming structure 

contract SimpleStorage2{

    //Note: Solidity is an OOPS Programming Language 

    //FavNum is what is called the Storage Variable 
    uint256 myfavNum;

    struct Person{
        uint favNum;
        string name;
    }

    //Initializing a custom Data Type follows the following syntax;
    //In Custom Data Type we need to specify the type of DataTyoe of both side of the Initializaton
    // CustomDataType visiblity varName = CustomDataType({key1: value, key2: value, ..... });
    // Person public pat = Person({favNum: 7,name: "pat"});

    //Dynamic array
    Person[] public listOfPeople; 

    //Hash table of the blockchain 
    mapping(string => uint256) public nameToFav;

    function addPeople(uint256 _favNum, string memory name) public{
        listOfPeople.push( Person(_favNum,name) );
        nameToFav[name] = _favNum;
    }

    function store(uint256 _favNum) public virtual{
        myfavNum = _favNum;
    }

    //View functions reads State from the Blockchain (Generally take no gas fees to execute)
    //Blue Functions represent that the functions aren't taking any Gas
    function retrieve() public view returns(uint256){
        return myfavNum;
    }
}