// SPDX-License-Identifier
pragma solidity 0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./iWhitelistedAddresses.sol";

contract sapanftpresale is ERC721Enumerable, Ownable {
    string _baseTokenURI;

    //The contract on the iWhitedlistedAddresses contract is called and given a
    //new variable as whitelist
    iWhitelistedAddress whitelist;
    //Right here is where the variable for when the presale will begin
    //This presale is defined as a bool and can only be called by the owner of the contract.
    bool public presaleStarted;

    //Right here presale variable is defined and is been used to terminate the
    //the presale window. It a uint variable and holds a block timestamp
    uint256 public presaleEnded;
    //Here we define the maximum amount of tokenid that can be minted.
    uint256 public maxtokenId = 20;
    //HThis keeps track of the amount of token that has been minted
    uint256 public tokenIds;

    //Here we define the amount the user need to pay to mint their nft successfully
    uint256 public _price = 0.001 ether;

    //This variable is meant to pause the contract when there is an unwanted activity or exploitation
    bool public _paused;

    modifier onlyWhenNotPaused() {
        require(!_paused, "Contract is currently paused");
        _;
    }

    // constructor(string memory baseURI, address whitelistcontract)
    //     ERC721("SapaNft", "Sapa")
    // {
    //     _baseTokenURI = baseURI;
    //     whitelist = iWhitelistedAddress(whitelistcontract);

    // }
    constructor(string memory baseURI, address whitelistContract)
        ERC721("Crypto Devs", "CD")
    {
        _baseTokenURI = baseURI;
        whitelist = iWhitelistedAddress(whitelistContract);
    }

    //This function can only be called by the owner of this function and a onlyowner keyword
    // is addded as a modifier to the function.
    function startPresale() public onlyOwner {
        presaleStarted = true;
        //The duration of the presale is set to be 5 minutes from time of start.
        presaleEnded = block.timestamp + 5 minutes;
    }

    function presaleMint() public payable onlyWhenNotPaused {
        require(
            presaleStarted && block.timestamp < presaleEnded,
            "Presale has end!!!"
        );
        require(
            whitelist.whitelistedAddresses(msg.sender),
            "You have not been whitelisted"
        );
        require(tokenIds < maxtokenId, "Exceeded max number");
        require(msg.value >= _price, "You do not enough money to mint");

        tokenIds += 1;

        _safeMint(msg.sender, tokenIds);
    }

    function mint() public payable onlyWhenNotPaused {
        require(
            presaleStarted && block.timestamp >= presaleEnded,
            "Public sales has not started yet"
        );
        require(tokenIds < maxtokenId, "Exceeded max number");
        require(msg.value >= _price, "You do not enough money to mint");
        tokenIds += 1;
        //This function here sends the user the nft they just minted.
        _safeMint(msg.sender, tokenIds);
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function withdraw() public payable onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) = _owner.call{value: amount}("");
        require(sent, "Not sent");
    }

    function paused(bool val) public {
        _paused = val;
    }

    receive() external payable {}

    fallback() external payable {}
}
