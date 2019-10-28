pragma solidity 0.5.8;


contract Election {

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(address => bool) public voters;

    mapping(uint => Candidate) public candidates;

    uint public candidatesCount;

    constructor () public {
        addCandidates("Candidate 1");
        addCandidates("Candidate 2");
    }

    event votedEvent( uint indexed _candidateId);

    function addCandidates(string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // En solidity puedes introducir metadatos en las funciones sin importar haberlas declarado
    // primera account web3.eth.getAccounts().then(function(acc){accounts=acc;}); accounts[0];
    function vote(uint _candidateId) public {
        // no votado si true hace la funcion , como un assert, no gasta gas si no lo hace, lo reenvia
        require(!voters[msg.sender]);
        // candidato valido
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount ++;
        // Para llamar un evento se le pone emit
        emit votedEvent(_candidateId);
    }

}