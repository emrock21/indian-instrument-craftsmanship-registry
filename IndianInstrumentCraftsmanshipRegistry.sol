// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract IndianInstrumentCraftsmanshipRegistry {

    struct InstrumentCraft {
        string region;               // Maharashtra, Tamil Nadu, Uttar Pradesh, etc.
        string lineageOrWorkshop;    // Miraj Karigar, Tanjore Veena makers, etc.
        string instrumentName;       // sitar, tabla, veena, sarangi, mridangam, etc.
        string materials;            // teak, jackwood, gourd, goat skin, bamboo, etc.
        string craftingTechnique;    // carving, hollowing, syahi application, reed making
        string acousticTraits;       // tonal warmth, sustain, resonance, timbre
        string uniqueness;           // cultural or technical distinctiveness
        address creator;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
    }

    struct CraftInput {
        string region;
        string lineageOrWorkshop;
        string instrumentName;
        string materials;
        string craftingTechnique;
        string acousticTraits;
        string uniqueness;
    }

    InstrumentCraft[] public crafts;

    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event CraftRecorded(
        uint256 indexed id,
        string instrumentName,
        string lineageOrWorkshop,
        address indexed creator
    );

    event CraftVoted(
        uint256 indexed id,
        bool like,
        uint256 likes,
        uint256 dislikes
    );

    constructor() {
        crafts.push(
            InstrumentCraft({
                region: "India",
                lineageOrWorkshop: "ExampleWorkshop",
                instrumentName: "Example Instrument (replace with real entries)",
                materials: "example materials",
                craftingTechnique: "example technique",
                acousticTraits: "example acoustic traits",
                uniqueness: "example uniqueness",
                creator: address(0),
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordCraft(CraftInput calldata c) external {
        crafts.push(
            InstrumentCraft({
                region: c.region,
                lineageOrWorkshop: c.lineageOrWorkshop,
                instrumentName: c.instrumentName,
                materials: c.materials,
                craftingTechnique: c.craftingTechnique,
                acousticTraits: c.acousticTraits,
                uniqueness: c.uniqueness,
                creator: msg.sender,
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );

        emit CraftRecorded(
            crafts.length - 1,
            c.instrumentName,
            c.lineageOrWorkshop,
            msg.sender
        );
    }

    function voteCraft(uint256 id, bool like) external {
        require(id < crafts.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;

        InstrumentCraft storage ic = crafts[id];

        if (like) {
            ic.likes += 1;
        } else {
            ic.dislikes += 1;
        }

        emit CraftVoted(id, like, ic.likes, ic.dislikes);
    }

    function totalCrafts() external view returns (uint256) {
        return crafts.length;
    }
}
