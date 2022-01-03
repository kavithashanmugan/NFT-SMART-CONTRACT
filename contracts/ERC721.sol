pragma solidity ^0.8.0;

contract ERC721 {
    event Transfer(address indexed _from, address indexed _to,uint256 _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    mapping(address => uint256 ) internal _balances;

    mapping(uint256 => address ) internal _owners;

    mapping(address => mapping(address => bool)) private _operatorApprovals;

    mapping(uint256 => address) private _tokenApprovals;

    //Returns the number of NFTS assigned to user
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "Address is zero");
        return _balances[owner];
    }

    //finds the owner of the NFT
    function ownerOf(uint256 tokenId) public view returns(address){
        address owner = _owners[tokenId];
        require(owner !=address(0),"Token Id does not exist");
        return owner;
    }

    //open-sea is example of operator
    //enables or disbales an operator to manage all of msg.senders assets.

    function setApprovalForAll(address operator, boolean approved) public {
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender , operator, approved);
    }

    //checks if an address is an operator for another address
    function isApprovedForAll( address owner, address operator) public view returns (bool){
        return _operatorApprovals[owner][operator];
    }

    function approve(address to,uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require( msg.sender == owner || isApprovedForAll(owner,msg.sender),"Msg.sender is not the owner or approver");
        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    //gets the approved address for a single NFT
    function getApproved(int256 tokenId) public view returns (address){
        require(_owner[tokenId] != address(0), "Token ID does not exist");
        return _tokenApprovals[tokenId];
    }

    //transfer ownership of NFT
    function transferFrom(address from, address to,uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(msg.sender == owner || getApproved(tokenId) = msg.sender || isApprovedForAll(owner, msg.sender),
        "Msg.sender is not the owner ");
        require(to != address(0),"Address is zero");
        require(_owners[tokenId] != address(0),"Token Id does not exist");
        approve(address(0), tokenId);

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);

    }
//standard transfer from
//checks if onERC721Recieved is implemented when sending to smart contracts
    function safeTransferFrom(address from,address to,uint256 tokenId,bytes memory _data) public {
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(),"Reciever not implemented")

    }

    function safeTransferFrom(address from,address to,uint256 tokenId) public {
        safeTransferFrom(from,to,tokenId,"");
    }


    //ERC165
    function supportsInterface(bytes4 interfaceId)public pure virtual returns(bool){

        return interfaceId == 0x80ac58cd;

    }



}

    function _checkOnERC721Received() private pure returns (bool){
        return true;
    }



}