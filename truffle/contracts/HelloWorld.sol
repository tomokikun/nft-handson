// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract HelloWorld {
    string greeting;

    constructor() {
        greeting = "Hello, Smart Contract!";
    }

    function getMessage() public view returns (string memory) {
        return greeting;
    }
}
