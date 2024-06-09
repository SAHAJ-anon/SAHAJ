// SPDX-License-Identifier: MIT
// File: SafeMath.sol
/**

 ░▒▓███████▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
 ░▒▓██████▓▒░░▒▓████████▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
       ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
       ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░ ░▒▓██████▓▒░ ░▒▓█████████████▓▒░  
                                                                                       
Get native funds privately and securely without sharing wallet addresses. Powered by $SHDW & 100% Secure. Embrace your SHADOW.

WEBSITE: https://shadow.fail
dAPP: https://app.shadow.fail
TELEGRAM: https://t.me/shdwportal
TWITTER: https://twitter.com/SHDW_BASE

*/

pragma solidity ^0.8.16;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {
    /**
     * @dev Multiplies two numbers, throws on overflow.
     */
    function mul(uint256 a, uint256 b) external pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

    /**
     * @dev Integer division of two numbers, truncating the quotient.
     */
    function div(uint256 a, uint256 b) external pure returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    /**
     * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
     */
    function sub(uint256 a, uint256 b) external pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    /**
     * @dev Adds two numbers, throws on overflow.
     */
    function add(uint256 a, uint256 b) external pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }

    function min(uint256 x, uint256 y) external pure returns (uint256) {
        return x < y ? x : y;
    }
}
// File: IERC721.sol

// This is an interface for the ERC721 token standard.
// ERC721 is a standard for non-fungible tokens (NFTs) on the Ethereum blockchain.

pragma solidity ^0.8.16;

interface IERC721 {
    // Transfers ownership of an NFT from one address to another.
    function transferFrom(address from, address to, uint256 tokenId) external;

    // Returns the owner of a specific NFT.
    function ownerOf(uint256 tokenId) external view returns (address);

    // Returns the approved address for a specific NFT.
    function getApproved(uint256 _tokenId) external view returns (address);

    // Approves another address to transfer the given NFT.
    function approve(
        address sender,
        uint256 _tokenId
    ) external returns (bool success);
}

// File: IERC20.sol

// This is an interface for the ERC20 token standard.
// ERC20 is a widely adopted standard for fungible tokens on the Ethereum blockchain.

pragma solidity ^0.8.16;

interface IERC20 {
    // Transfers a specified amount of tokens from the sender to a recipient.
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    // Returns the balance of tokens for a specific account.
    function balanceOf(address account) external view returns (uint256);

    // Returns the amount of tokens that the spender is allowed to spend on behalf of the owner.
    function allowance(
        address token,
        address sender
    ) external view returns (uint256 remaining);

    // Allows the owner of tokens to approve another address to spend a specified amount of tokens on their behalf.
    function approve(
        address sender,
        uint256 amount
    ) external returns (bool success);
}

// File: shadow.sol

pragma solidity ^0.8.16;

// Import the interfaces for IERC20 and IERC721 tokens

// Import the SafeMath library

/**
 * @title Shadow
 * @dev The Directory contract allows users to publish their public keys on blockchain,
 * consisting of the parameters x_cor, y_cor, and sharedSecret.
 * These keys allow the receiver to generate the private key associated with his stealth address.
 * Users publish their public keys by invoking the appropriate functions in the contract.
 * The contract maintains a log of published keys and keeps track of the total funds sent and received.
 * Users can transfer native coins, ERC20, and Non-fungible tokens to a designated recipient stealth address,
 * authorized by their published keys.
 */

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");
    struct publickeys {
        bytes32 x_cor;
        bytes32 y_cor;
        bytes2 sharedSecret;
    }
    struct TestStorage {
        address devWallet;
        uint256 totalFunds;
        uint256 totalStealthAdd;
        address owner;
        undefined[] logs;
        string contractName;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
