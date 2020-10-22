// SPDX-License-Identifier: MIT
pragma solidity ^0.4.2;

contract Election {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
        uint totalVoteCount;
    }

    mapping (uint => Candidate) public candidates;

    uint public candidatesCount;

    uint public totalVoteCount;

    mapping (address => bool) public voters;

    event votedEvent (
        uint indexed _candidateId
    );

    function addCandidate (string _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate (candidatesCount, _name, 0, 0);
    }

    function vote (uint _candidateId) public {
        require (!voters[msg.sender]);
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount++;
        totalVoteCount++;
        for (uint i = 1; i <= candidatesCount; ++i) {
            candidates[i].totalVoteCount = totalVoteCount;
        }
        emit votedEvent(_candidateId);
    }

    constructor () public {
        addCandidate("Hillary Clinton - Democratic");
        addCandidate("Donald Trump - Republican");
        addCandidate("Jill Stein - Green");
        addCandidate("Gary Johnson - Libertarian");
    }
}