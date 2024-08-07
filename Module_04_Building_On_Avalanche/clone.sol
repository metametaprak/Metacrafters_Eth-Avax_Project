// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GameClone is ERC20 {
    address public owner;

    mapping(uint256 => string) public itemName;
    mapping(uint256 => uint256) public itemPrice;
    mapping(address => mapping(uint256 => bool)) public redeemedItems;
    mapping(address => uint256) public redeemedItemCount;

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    constructor() ERC20("Polygon", "Matic") {
        owner = msg.sender;
        _addItemToStore(0, "sticker", 500);
        _addItemToStore(1, "phone", 1000);
        _addItemToStore(2, "laptop", 20000);
        _addItemToStore(3, "servers", 25000);
    }

    event Redeem(address indexed user, string itemName);

    function _addItemToStore(uint256 itemId, string memory _itemName, uint256 _itemPrice) internal {
        itemName[itemId] = _itemName;
        itemPrice[itemId] = _itemPrice;
    }

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
}
