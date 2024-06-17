# Metacrafters_ETH+AVAX_Intermediate_Project_03_Submission


This Solidity smart contract, named CustomToken, exemplifies the diverse error handling mechanisms available in Solidity. It enables users to conduct deposit and withdrawal operations, ensuring compliance with specific conditions through the use of require statements. Furthermore, the contract demonstrates the implementation of assert and revert for robust error management. By illustrating these methods, the contract provides a comprehensive understanding of error handling in Solidity, emphasizing the importance of condition enforcement and the proper handling of unexpected states.

# Contract Explanation 
```solidity
/ SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Customtoken is ERC20 {
     
    string public tokenName = "Binance Coin";
    string public tokenSymbol = "BNB";
    
    constructor() ERC20(tokenName, tokenSymbol) {}
    
    function mint(address _to, uint256 _amount) public {
        _mint(_to, _amount);
    }

    function burn(uint256 _amount) public {
        _burn(msg.sender, _amount);
    }
}
```

A smart contract for an ERC20 token named "Binance Coin" with the symbol "BNB". It is written using the Solidity version 0.8.26 and utilizes the OpenZeppelin library to inherit standard ERC20 functionalities.

**SPDX License Identifier:** The comment // SPDX-License-Identifier: MIT specifies that this code is licensed under the MIT License, which is a permissive free software license.

**Pragma Directive:** pragma solidity 0.8.26; specifies that the Solidity compiler version 0.8.26 should be used for compiling this contract, ensuring compatibility and preventing potential issues with different compiler versions.

**Importing OpenZeppelin ERC20:** import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; imports the ERC20 implementation from the OpenZeppelin library, providing standard functionalities such as transfer, balance, and allowance.

**Contract Definition:** The contract MyToken inherits from the OpenZeppelin ERC20 contract.

**Token Name and Symbol:** Two public string variables, tokenName and tokenSymbol, are defined to store the name ("Binance Coin") and symbol ("BNB") of the token.

**Constructor:** The constructor constructor() ERC20(tokenName, tokenSymbol) {} initializes the ERC20 token with the specified name and symbol by calling the constructor of the parent ERC20 contract.

**Mint Function:** The mint function allows new tokens to be created and assigned to a specified address. It takes two parameters: the address _to where the new tokens will be sent, and the amount _amount of tokens to mint. It calls the internal _mint function provided by the ERC20 contract.

**Burn Function:** The burn function allows the sender to destroy a specified amount of their tokens, reducing the total supply. It takes one parameter _amount, representing the number of tokens to burn. It calls the internal _burn function, which deducts the tokens from the sender's balance.

Overall, this contract provides basic functionalities for minting and burning an ERC20 token, leveraging the secure and widely-used OpenZeppelin library to ensure robust and standard-compliant implementation.

# Deploy Contract 

Deploy the contract using Remix IDE or any other Ethereum development framework(Hardhat & Foundry).

