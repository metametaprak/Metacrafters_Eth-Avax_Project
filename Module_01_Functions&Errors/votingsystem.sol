// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract VotingSystem {

    address public owner;
    uint public proposalCount;

    struct Proposal {

        uint id;
        string description;
        uint voteCount;
        bool finalized;

    }

    mapping(uint => Proposal) public proposals;
    mapping(address => mapping(uint => bool)) public votes;

    event ProposalCreated(uint id, string description);
    event Voted(address voter, uint proposalId);
    event ProposalFinalized(uint proposalId, bool accepted);

    modifier onlyOwner() {

        if (msg.sender != owner) {
            revert("Only the owner can perform this action");
        }
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createProposal(string memory description) public onlyOwner {
        
        proposalCount++;
        proposals[proposalCount] = Proposal(proposalCount, description, 0, false);
        emit ProposalCreated(proposalCount, description);
    }

    function vote(uint proposalId) public {

        Proposal storage proposal = proposals[proposalId];

        if (proposal.id == 0) {
            revert("Proposal does not exist");
        }
        if (proposal.finalized) {
            revert("Proposal has been finalized");
        }
        if (votes[msg.sender][proposalId]) {
            revert("You have already voted on this proposal");
        }

        votes[msg.sender][proposalId] = true;
        proposal.voteCount++;

        emit Voted(msg.sender, proposalId);
    }

    function finalizeProposal(uint proposalId) public onlyOwner {

        Proposal storage proposal = proposals[proposalId];

        if (proposal.id == 0) {
            revert("Proposal does not exist");
        }
        if (proposal.finalized) {
            revert("Proposal has already been finalized");
        }

        proposal.finalized = true;

        if (proposal.voteCount > 0) {
            emit ProposalFinalized(proposalId, true);
        } else {
            emit ProposalFinalized(proposalId, false);
        }

        // Assert to ensure the proposal is marked as finalized
        assert(proposal.finalized == true);
    }

    function getProposal(uint proposalId) public view returns (uint, string memory, uint, bool) {

        Proposal storage proposal = proposals[proposalId];

        return (proposal.id, proposal.description, proposal.voteCount, proposal.finalized);
    }

    function transferOwnership(address newOwner) public onlyOwner {
        
        require(newOwner == address(0),"New owner address cannot be zero address");
        owner = newOwner;
    }
}
