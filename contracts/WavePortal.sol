
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0; 

import "hardhat/console.sol";

contract WavePortal {
    
    uint256 totalWaves; //contract proprety

    uint256 private seed;

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
        bool airdrop;
    }

    event NewWave(address indexed _from, string message, uint256 timestamp,  bool airdrop);
    
    Wave[] waves;

    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart");
        seed = (block.timestamp + block.difficulty) % 100;
    } // contract constructor

    function wave(string memory _message) public {

        bool success = false;

        require(
            lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
            'Wait 30s'
        );
        
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves +=1;
        console.log("%s has waved!", msg.sender);

        uint prizeAmount = 0.0001 ether;

        seed = (block.difficulty + block.timestamp + seed ) %100;
        console.log("Random # generated: %d", seed);

        if (seed <= 50 ) {
            console.log("%s won!", msg.sender );
            require (
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
             );

            (success, ) = (msg.sender).call{value: prizeAmount}("");

            require(success, "Failed to withdraw money from contract");
        }
        

        emit NewWave(msg.sender, _message, block.timestamp, success);

        waves.push(Wave(msg.sender, _message, block.timestamp, success));
        
    }

    function getAllWaves() public view returns (Wave[] memory){
        return waves;
    }

    function unwave() public {
        totalWaves -=1;
        console.log("%s has unwaved!", msg.sender);
        } //unwave

    function getTotalWaves() public view returns (uint256) {
        // console.log("We have %d total waves!", totalWaves);
        return totalWaves;
        } //logs the total number of waves in the console 
}       
