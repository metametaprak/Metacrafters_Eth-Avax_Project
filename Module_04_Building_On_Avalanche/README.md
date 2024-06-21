# Degen Gaming Introduction 

 Degen Gaming 🎮, a renowned game studio, has approached you to create a unique token that can reward players and take their game to the next level. You have been tasked with creating a token that can be earned by players in their game and then exchanged for rewards in their in-game store. A smart step towards increasing player loyalty and retention 🧠

# Project Tasks

**Minting new tokens:** The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.</br>
**Transferring tokens:** Players should be able to transfer their tokens to others.</br>
**Redeeming tokens:** Players should be able to redeem their tokens for items in the in-game store.</br>
**Checking token balance:** Players should be able to check their token balance at any time.</br>
**Burning tokens:** Anyone should be able to burn tokens, that they own, that are no longer needed.</br>

# Contract Explanation 

Sure, let's go through the code step-by-step and explain what each part does.

### SPDX License Identifier
```solidity
// SPDX-License-Identifier: MIT
```
This specifies the software license for the contract. The MIT license is a permissive license allowing reuse with minimal restrictions.

### Pragma Directive
```solidity
pragma solidity 0.8.26;
```
This specifies the version of the Solidity compiler to be used for compiling this contract. Here, it’s set to version 0.8.26.

### Contract Declaration
```solidity
contract GameClone {
```
This declares a new contract named `GameClone`.

### State Variables
```solidity
    address public owner;
    string public name;
    string public symbol; 
    uint8 public decimals = 10;
    uint256 public totalSupply = 0;

    mapping(uint256 => string) public ItemName;
    mapping(uint256 => uint256) public Itemprice;
    mapping(address => uint256) public balance;
    mapping(address => mapping(uint256 => bool)) public redeemedItems;
    mapping(address => uint256) public redeemedItemCount;
```
These are the state variables used in the contract:
- `owner`: Address of the contract owner.
- `name`: Name of the token.
- `symbol`: Symbol of the token.
- `decimals`: Decimal places for the token (10 in this case).
- `totalSupply`: Total supply of tokens.
- `ItemName`: Mapping from item IDs to their names.
- `Itemprice`: Mapping from item IDs to their prices.
- `balance`: Mapping from addresses to their token balances.
- `redeemedItems`: Nested mapping to track redeemed items for each address.
- `redeemedItemCount`: Mapping from addresses to count of redeemed items.

### Constructor
```solidity
    constructor() {

        name = "Polygon";
        symbol = "Matic";
        owner = msg.sender;

        GameStore(0, "sticker", 500);
        GameStore(1, "phone", 1000);
        GameStore(2, "laptop", 20000);
        GameStore(3, "servers", 25000);
    }
```
The constructor initializes the contract by setting the token name to "Polygon", symbol to "Matic", and owner to the address that deploys the contract. It also sets up an in-game store with items and their prices using the `GameStore` function.

### Events
```solidity
    event Mint(address indexed to, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Redeem(address indexed user, string itemName);
```
These are events that the contract emits to notify off-chain applications of certain actions:
- `Mint`: Emitted when tokens are minted.
- `Transfer`: Emitted when tokens are transferred.
- `Burn`: Emitted when tokens are burned.
- `Redeem`: Emitted when an item is redeemed.

### GameStore Function
```solidity
    function GameStore(uint256 itemId, string memory _itemName, uint256 _itemPrice) public {
        require(owner == msg.sender,"This Function can only be used by the owner");
        ItemName[itemId] = _itemName;
        Itemprice[itemId] = _itemPrice;
    }
```
This function sets up items in the game store. It can only be called by the contract owner.

### Mint Function
```solidity
    function mint() payable external {
        require(owner == msg.sender,"This Function can only be used by the owner");
        totalSupply += msg.value;
        balance[msg.sender] += msg.value;
        emit Mint(msg.sender, msg.value);
        emit Transfer(address(0), msg.sender, msg.value);
    }
```
This function allows the owner to mint new tokens by sending ether to the contract. The number of tokens minted is equal to the amount of ether sent.

### Balance Check Function
```solidity
    function balanceOf(address accountAddress) external view returns (uint256) {
        return balance[accountAddress];
    }
```
This function allows anyone to check the token balance of a given address.

### Transfer Function
```solidity
    function transfer(address receiver, uint256 amount) external returns (bool) {
        require(balance[msg.sender] >= amount, "Insufficient Token.");
        balance[msg.sender] -= amount;
        balance[receiver] += amount;
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }
```
This function allows token holders to transfer tokens to another address.

### Burn Function
```solidity
    function burn(uint256 amount) external {
        require(amount <= balance[msg.sender], "Insufficient Token.");
        balance[msg.sender] -= amount;
        totalSupply -= amount;
        emit Burn(msg.sender, amount);
        emit Transfer(msg.sender, address(0), amount);
    }
```
This function allows token holders to burn (destroy) their tokens, reducing the total supply.

### Redeem Function
```solidity
    function Itemredeem(uint256 accId) external returns (string memory) {
        uint256 redemptionAmount = Itemprice[accId];
        require(balance[msg.sender] >= redemptionAmount, "Insufficient Token to redeem the item.");
        balance[msg.sender] -= redemptionAmount;
        redeemedItems[msg.sender][accId] = true;
        redeemedItemCount[msg.sender]++;
        emit Redeem(msg.sender, ItemName[accId]);
        return ItemName[accId];
    }
```
This function allows players to redeem tokens for items in the in-game store. It checks if the player has enough tokens and updates their balance and redeemed items.

### Get Redeemed Item Count Function
```solidity
    function getRedeemedItemCount(address user) external view returns (uint256) {
        return redeemedItemCount[user];
    }
```
This function returns the count of items a user has redeemed.

This contract implements a basic token system with minting, transferring, burning, and redeeming functionalities, along with an in-game store mechanism.
