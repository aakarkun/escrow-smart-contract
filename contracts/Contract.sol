pragma solidity ^0.4.21;

contract Contract {
    string public name;

constructor (string passedName) public {
        name = passedName;
    }

    function setName(string newName) public {
        name = newName;
    }
    

}