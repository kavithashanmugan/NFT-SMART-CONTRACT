pragma solidity 0.8.0;

import "./ERC721.sol";

contract SpiderMan is ERC721{
    string public name;
    string public symbol;
    uint256 public tokenCount;

    mapping(uint256 => string) private _tokenURIs;

    constructor(string memory _name,string memory _symbol){
        name = _name;
        symbol = _symbol;
        
    }


//Returns a URL that points to metadata
    function tokenURI(uint256 tokenId) public view returns (string memory){

        require(_owners[tokenId] != address(0),"Token Id does not exist");
        return _tokenURIs[tokenId];
    }

    function mint(string memory tokenURI) public {
         tokenCount +=1;
        _balances[msg.sender] +=1;
        _owners[tokenCount] = msg.sender;
        _tokenURIs[tokenCount] = _tokenURI;

        emit Transfer(address(0),msg.sender,tokenCount);
    }
}