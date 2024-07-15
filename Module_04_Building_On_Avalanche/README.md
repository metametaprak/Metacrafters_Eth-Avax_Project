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

This Solidity contract, `GameClone`, extends the ERC20 token standard to create a token named "Polygon" with the symbol "Matic". Here's a detailed explanation of each component of the contract:

### License and Solidity Version
```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;
```
- **SPDX License Identifier**: Specifies the license under which the contract is released, in this case, MIT.
- **Pragma Directive**: Indicates that the contract is written for Solidity version 0.8.18.

### Imports
```solidity
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
```
- **OpenZeppelin ERC20**: Imports the ERC20 contract implementation from the OpenZeppelin library, which provides standard functionality for ERC20 tokens.

### Contract Declaration
```solidity
contract GameClone is ERC20 {
    address public owner;
```
- **GameClone**: Declares a contract named `GameClone` that inherits from the `ERC20` contract.
- **owner**: A state variable to store the address of the contract owner.

### State Variables
```solidity
    mapping(uint256 => string) public itemName;
    mapping(uint256 => uint256) public itemPrice;
    mapping(address => mapping(uint256 => bool)) public redeemedItems;
    mapping(address => uint256) public redeemedItemCount;
```
- **itemName**: Maps item IDs to item names.
- **itemPrice**: Maps item IDs to item prices in tokens.
- **redeemedItems**: Tracks whether a user has redeemed a specific item.
- **redeemedItemCount**: Counts the number of items a user has redeemed.

### Modifier
```solidity
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }
```
- **onlyOwner**: A modifier to restrict access to certain functions to the contract owner only.

### Constructor
```solidity
    constructor() ERC20("Polygon", "Matic") {
        owner = msg.sender;
        _addItemToStore(0, "sticker", 500);
        _addItemToStore(1, "phone", 1000);
        _addItemToStore(2, "laptop", 20000);
        _addItemToStore(3, "servers", 25000);
    }
```
- **Constructor**: Initializes the ERC20 token with the name "Polygon" and symbol "Matic". It also sets the owner to the deployer of the contract and adds some initial items to the store with their prices.

### Events
```solidity
    event Redeem(address indexed user, string itemName);
```
- **Redeem**: An event that is emitted when a user redeems an item.

### Internal Function
```solidity
    function _addItemToStore(uint256 itemId, string memory _itemName, uint256 _itemPrice) internal {
        itemName[itemId] = _itemName;
        itemPrice[itemId] = _itemPrice;
    }
```
- **_addItemToStore**: An internal function to add items to the store. It sets the item name and price for a given item ID.

### External Functions
```solidity
    function addItemToStore(uint256 itemId, string memory _itemName, uint256 _itemPrice) external onlyOwner {
        _addItemToStore(itemId, _itemName, _itemPrice);
    }

    function mint(uint256 amount) external onlyOwner {
        _mint(msg.sender, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function redeemItem(uint256 itemId) external returns (string memory) {
        uint256 redemptionAmount = itemPrice[itemId];
        require(balanceOf(msg.sender) >= redemptionAmount, "Insufficient tokens to redeem the item.");

        _burn(msg.sender, redemptionAmount);
        redeemedItems[msg.sender][itemId] = true;
        redeemedItemCount[msg.sender]++;
        emit Redeem(msg.sender, itemName[itemId]);

        return itemName[itemId];
    }

    function getRedeemedItemCount(address user) external view returns (uint256) {
        return redeemedItemCount[user];
    }
```
- **addItemToStore**: Adds new items to the store. Only the owner can call this function.
- **mint**: Mints new tokens to the owner's address. Only the owner can call this function.
- **burn**: Burns a specified amount of tokens from the caller's address.
- **redeemItem**: Allows users to redeem items using their tokens. It burns the required amount of tokens and marks the item as redeemed.
- **getRedeemedItemCount**: Returns the count of items redeemed by a specific user.

### Summary
This contract allows the owner to mint and manage an ERC20 token called "Polygon" with the symbol "Matic". Users can redeem items from a store using these tokens, and the contract tracks the items and their prices, as well as the items redeemed by each user.
