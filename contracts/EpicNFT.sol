// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import { Base64 } from "./libraries/Base64.sol";


contract EpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string[] firstWords = ['lewd', 'lame', 'real', 'rambunctious', 'functional', 'shivering', 'intelligent', 'cruel', 'didactic', 'sophisticated', 'overrated', 'low', 'hanging', 'great', 'shaky', 'dangerous', 'alluring', 'caring', 'decorous', 'torpid'];
    string[] secondWords = ['flat', 'tasty', 'nebulous', 'elfin', 'wandering', 'private', 'romantic', 'exultant', 'faulty', 'stingy', 'puzzled', 'vivacious', 'whimsical', 'taboo', 'gifted', 'lying', 'huge', 'educational', 'acid', 'several'];
    string[] thirdWords = ['poem', 'performance', 'piano', 'combination', 'mood', 'literature', 'knowledge', 'application', 'ambition', 'aspect', 'wife', 'drama', 'climate', 'context', 'protection', 'queen', 'airport', 'indication', 'highway', 'blood'];

    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    constructor() ERC721 ("SquareNFT", "SQUARE") {
        console.log("This is my NFT contract. Woah!");
    }

    function PickRandomFirstWord(uint256 tokenId) public view  returns(string memory) {
        uint256 n = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
        return firstWords[n % firstWords.length];
    }

    function PickRandomSecondWord(uint256 tokenId) public view  returns(string memory) {
        uint256 n = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
        return secondWords[n % secondWords.length];
    }

    function PickRandomThirdWord(uint256 tokenId) public view  returns(string memory) {
        uint256 n = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
        return thirdWords[n % thirdWords.length];
    }


    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    event NewEpicNFTMinted(address sender, uint256 tokenId);

    function makeEpicNFT() public {
        uint256 newItemId = _tokenIds.current();

        string memory first = PickRandomFirstWord(newItemId);
        string memory second = PickRandomSecondWord(newItemId);
        string memory third = PickRandomThirdWord(newItemId);
        string memory combinedWord = string(abi.encodePacked(first, second, third));


        string memory finalSvg = string(abi.encodePacked(baseSvg, combinedWord, "</text></svg>"));

        string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "',
                    // We set the title of our NFT as the generated word.
                    combinedWord,
                    '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                    // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                    Base64.encode(bytes(finalSvg)),
                    '"}'
                )
            )
        )

          
    );
 

    // Just like before, we prepend data:application/json;base64, to our data.
    string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );

   console.log("\n--------------------");
    console.log(finalTokenUri);
    console.log("--------------------\n");


    _safeMint(msg.sender, newItemId);
    
    // Update your URI!!!
    _setTokenURI(newItemId, finalTokenUri);
  
    _tokenIds.increment();

    emit NewEpicNFTMinted(msg.sender, newItemId);

    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    }
}