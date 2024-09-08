// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./UserManagment.sol";

contract Voting {
    mapping(address => bool) public hasVoted;
    mapping(address => bool) public isVerified; // New mapping for identity verification
    mapping(string => uint) public votesReceived;
    string[] public candidateList;

    // Event for voting
    event VoteCasted(address indexed voter, string candidate);

    // Constructor initializes the candidate list
    constructor(string[] memory candidateNames) {
        candidateList = candidateNames;
    }

    // Function to verify voter identity
    function verifyIdentity(address voter) public {
        // Only the contract owner or an authorized entity should call this
        isVerified[voter] = true; // Mark the voter as verified
    }

    // Vote function
    function vote(string memory candidate) public {
        require(isVerified[msg.sender], "You must verify your identity before voting.");
        require(!hasVoted[msg.sender], "You have already voted.");
        require(validCandidate(candidate), "Invalid candidate.");

        votesReceived[candidate] += 1;
        hasVoted[msg.sender] = true;

        // Emit event when a vote is cast
        emit VoteCasted(msg.sender, candidate);
    }

    // Check if the candidate is valid
    function validCandidate(string memory candidate) view public returns (bool) {
        for (uint i = 0; i < candidateList.length; i++) {
            if (keccak256(abi.encodePacked(candidateList[i])) == keccak256(abi.encodePacked(candidate))) {
                return true;
            }
        }
        return false;
    }

    // Function to get the candidate list
    function getCandidates() public view returns (string[] memory) {
        return candidateList;
    }
}


