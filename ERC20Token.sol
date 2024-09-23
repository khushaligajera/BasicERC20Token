 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract ERCToken {
    uint256 public totalSupply;
    string public tokenName;
    string public symbol;
    address public owner;
    mapping(address => mapping(address => uint)) public _allowance;
     mapping(address => mapping(address => bool)) public approved;
    mapping(address => uint256) public balanceOf;


    constructor(
        uint256 _totalSupply,
        string memory _tokenName,
        string memory _symbol
    ) {
        totalSupply = _totalSupply;
        tokenName = _tokenName;
        symbol = _symbol;
        owner = msg.sender;
        balanceOf[owner]=totalSupply;
    }


    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }


    function mint(uint256 mintingAmount) public onlyOwner {
        totalSupply += mintingAmount;
    }


    function burn(uint256 burnAmount) public onlyOwner {
        totalSupply -= burnAmount;
    }


    function approve(
        address sender,
        address recipient,
        uint256 amount
    ) public {
        require(balanceOf[sender] >= amount, "insufficient balance");
        require(
            recipient != address(0),
            "recipient address should not be zero"
        );
       approved[sender][recipient]=true;
        _allowance[sender][recipient] = amount;
    }


    function transfer(address to, uint256 amount) public {
        require(balanceOf[msg.sender] > amount, "insufficient balance");
        require(to != address(0), "address should not be zero");
        _transfer(msg.sender, to, amount);
    }


    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal {
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
    }


    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public {
 
        require(approved[from][msg.sender], "not allowed");
        require(_allowance[from][msg.sender]>amount,"insufficient amount");


        _transfer(from, to, amount);
        _allowance[from][msg.sender]-=amount;
    }
}


