pragma solidity ^0.5.0;

contract TokenERC721{

    address internal creator;
    uint256 internal maxId;
    mapping(address => uint256) internal balances;
    mapping(uint256 => address) internal owners;
    string private __name;
    string private __symbol;
    mapping(uint256 => string) private _tokenURIs;

    constructor(uint _initialSupply,string memory _name, string memory _symbol) public {
        creator = msg.sender;
        balances[msg.sender] = _initialSupply;
        maxId = _initialSupply;
        __name = _name;
        __symbol = _symbol;
    }

    function balanceOf(address _owner) external view returns (uint256){
        return balances[_owner];
    }    

    function issueToken(string memory uriBase ) public{
        balances[msg.sender] = balances[msg.sender] + 1;        
        maxId += 1 ;
        owners[maxId] = msg.sender;
        _tokenURIs[maxId]  = uriBase;
    }

    function ownerOf(uint256 _tokenId) public view returns(address){
            return owners[_tokenId];
    }    


    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        owners[_tokenId] = _to;
        balances[_from]--;
        balances[_to]++;     
    }

    function tokenURI(uint256 _tokenId) public view returns (string memory){
        return _tokenURIs[_tokenId]; 
    }

    /// @notice A descriptive name for a collection of NFTs in this contract
    function name() external view returns (string memory _name){
        //_name = "Name must be hard coded";
        _name = __name;
    }

    /// @notice An abbreviated name for NFTs in this contract
    function symbol() external view returns (string memory _symbol){
        //_symbol = "Symbol must be hard coded";
        _symbol = __symbol;
    }
}
