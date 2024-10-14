// SPDX-License-Identifier: MIT
pragma solidity =0.8.15 ^0.8.0;

// lib/openzeppelin-contracts/contracts/utils/Context.sol

// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// lib/openzeppelin-contracts/contracts/access/Ownable.sol

// OpenZeppelin Contracts (last updated v4.7.0) (access/Ownable.sol)

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// src/legacy/AddressManager.sol

/// @custom:legacy
/// @title AddressManager
/// @notice AddressManager is a legacy contract that was used in the old version of the Optimism
///         system to manage a registry of string names to addresses. We now use a more standard
///         proxy system instead, but this contract is still necessary for backwards compatibility
///         with several older contracts.
contract AddressManager is Ownable {
    /// @notice Mapping of the hashes of string names to addresses.
    mapping(bytes32 => address) private addresses;

    /// @notice Emitted when an address is modified in the registry.
    /// @param name       String name being set in the registry.
    /// @param newAddress Address set for the given name.
    /// @param oldAddress Address that was previously set for the given name.
    event AddressSet(string indexed name, address newAddress, address oldAddress);

    /// @notice Changes the address associated with a particular name.
    /// @param _name    String name to associate an address with.
    /// @param _address Address to associate with the name.
    function setAddress(string memory _name, address _address) external onlyOwner {
        bytes32 nameHash = _getNameHash(_name);
        address oldAddress = addresses[nameHash];
        addresses[nameHash] = _address;

        emit AddressSet(_name, _address, oldAddress);
    }

    /// @notice Retrieves the address associated with a given name.
    /// @param _name Name to retrieve an address for.
    /// @return Address associated with the given name.
    function getAddress(string memory _name) external view returns (address) {
        return addresses[_getNameHash(_name)];
    }

    /// @notice Computes the hash of a name.
    /// @param _name Name to compute a hash for.
    /// @return Hash of the given name.
    function _getNameHash(string memory _name) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(_name));
    }
}

// src/legacy/ResolvedDelegateProxy.sol

/// @custom:legacy
/// @title ResolvedDelegateProxy
/// @notice ResolvedDelegateProxy is a legacy proxy contract that makes use of the AddressManager to
///         resolve the implementation address. We're maintaining this contract for backwards
///         compatibility so we can manage all legacy proxies where necessary.
contract ResolvedDelegateProxy {
    /// @notice Mapping used to store the implementation name that corresponds to this contract. A
    ///         mapping was originally used as a way to bypass the same issue normally solved by
    ///         storing the implementation address in a specific storage slot that does not conflict
    ///         with any other storage slot. Generally NOT a safe solution but works as long as the
    ///         implementation does not also keep a mapping in the first storage slot.
    mapping(address => string) private implementationName;

    /// @notice Mapping used to store the address of the AddressManager contract where the
    ///         implementation address will be resolved from. Same concept here as with the above
    ///         mapping. Also generally unsafe but fine if the implementation doesn't keep a mapping
    ///         in the second storage slot.
    mapping(address => AddressManager) private addressManager;

    /// @param _addressManager  Address of the AddressManager.
    /// @param _implementationName implementationName of the contract to proxy to.
    constructor(AddressManager _addressManager, string memory _implementationName) {
        addressManager[address(this)] = _addressManager;
        implementationName[address(this)] = _implementationName;
    }

    /// @notice Fallback, performs a delegatecall to the resolved implementation address.
    // solhint-disable-next-line no-complex-fallback
    fallback() external payable {
        address target = addressManager[address(this)].getAddress((implementationName[address(this)]));

        require(target != address(0), "ResolvedDelegateProxy: target address must be initialized");

        // slither-disable-next-line controlled-delegatecall
        (bool success, bytes memory returndata) = target.delegatecall(msg.data);

        if (success == true) {
            assembly {
                return(add(returndata, 0x20), mload(returndata))
            }
        } else {
            assembly {
                revert(add(returndata, 0x20), mload(returndata))
            }
        }
    }
}