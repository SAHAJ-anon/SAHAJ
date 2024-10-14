/*
Crypto Processing Unit - $CPU

Website:       https://cryptopu.io
Doc:           https://docs.cryptopu.io/
dAPP:          https://dapp.cryptopu.io/
Telegram:      https://t.me/CPU_official
Telegram Bot:  https://t.me/CryptoProcessingUnitBot
Twitter:       https://twitter.com/CPU_erc
*/


// File: @openzeppelin/contracts/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

// File: @openzeppelin/contracts/utils/Context.sol


// OpenZeppelin Contracts (last updated v5.0.1) (utils/Context.sol)

pragma solidity ^0.8.20;

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

    function _contextSuffixLength() internal view virtual returns (uint256) {
        return 0;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol


// OpenZeppelin Contracts (last updated v5.0.0) (access/Ownable.sol)

pragma solidity ^0.8.20;


/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * The initial owner is set to the address provided by the deployer. This can
 * later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    /**
     * @dev The caller account is not authorized to perform an operation.
     */
    error OwnableUnauthorizedAccount(address account);

    /**
     * @dev The owner is not a valid owner account. (eg. `address(0)`)
     */
    error OwnableInvalidOwner(address owner);

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the address provided by the deployer as the initial owner.
     */
    constructor(address initialOwner) {
        if (initialOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(initialOwner);
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
        if (owner() != _msgSender()) {
            revert OwnableUnauthorizedAccount(_msgSender());
        }
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby disabling any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        if (newOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
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

// File: cpustake.sol


pragma solidity ^0.8.20;



contract CPUStaking is Ownable {
    event StakeEvent(uint256 value, address from);
    event ClaimEvent(uint256 value, address from);
    event WithdrawEvent(uint256 value, address to);

    error UnauthorizedWithdrawAccount(address account);
    error WithdrawAccountIsNotSet();

    // Token for rewards
    address public RewardTokenAddress = address(0);
    address public WithdrawAccount = address(0);

    constructor(address rewardToken) Ownable(msg.sender) {
        require(rewardToken != address(0), "Invalid reward token address");
        RewardTokenAddress = rewardToken;
        WithdrawAccount = msg.sender;
    }

    uint256 public totalStakedAmount = 0;
    mapping(address => uint256) public Stakes;
    mapping(address => bool) public inStakers;
    address[] public Stakers;

    // record all staked amount, despite unstake
    uint256 public totalStakedRecord = 0;
    // record all reward sent, despite claimed
    uint256 public totalRewardSentRecord = 0;
    mapping(address => uint256) public waitForClaim;

    function ClaimRewards() external returns (bool) {
        require(totalStakedAmount > 0, "No stakes");
        uint256 amount = waitForClaim[msg.sender];
        require(
            balanceOfRewardToken() >= amount,
            "Insufficient reward balance"
        );
        if (amount == 0) {
            return false;
        }

        waitForClaim[msg.sender] -= amount;

        _claimRewards(amount);

        return true;
    }

    function CalculateReward() public view returns (uint256) {
        return waitForClaim[msg.sender];
    }

    function _claimRewards(uint256 amount) private {
        _transferRewardToken(msg.sender, amount);

        emit ClaimEvent(amount, msg.sender);

        return;
    }

    function Stake(uint256 amount) external {
        // use erc20 transfer for this contract is staking erc20 token
        safeTransferFrom(RewardTokenAddress, msg.sender, address(this), amount);
        // total
        totalStakedAmount += amount;
        totalStakedRecord += amount;
        // user
        if(!inStakers[msg.sender]) {
            inStakers[msg.sender] = true;
            Stakers.push(msg.sender);
        }
        Stakes[msg.sender] += amount;


        emit StakeEvent(amount, msg.sender);

        return;
    }

    function Unstake(uint256 amount) public {
        require(Stakes[msg.sender] >= amount, "Insufficient staked amount");
        IERC20(RewardTokenAddress).transfer(msg.sender, amount);

        // record unstake
        totalStakedAmount -= amount;
        Stakes[msg.sender] -= amount;
    }

    function sendReward(uint256 amount) public withdrawOrOwner returns (bool) {
        // transfer to address(this)
        safeTransferFrom(RewardTokenAddress, msg.sender, address(this), amount);
        totalRewardSentRecord += amount;
        // according to current stakes, calculate rewards, and put into waitForClaim
        for (uint256 i = 0; i < Stakers.length; i++) {
            address staker = Stakers[i];

            uint256 reward = (amount * Stakes[staker]) / totalStakedAmount;
            waitForClaim[staker] += reward;
        }
        return true;
    }

    function balanceOfRewardToken() public view returns (uint256) {
        return IERC20(RewardTokenAddress).balanceOf(address(this));
    }

    function _transferRewardToken(
        address to,
        uint256 amount
    ) internal returns (bool) {
        return IERC20(RewardTokenAddress).transfer(to, amount);
    }

    function Withdraw(uint256 amount) external withdrawOrOwner returns (bool) {
        require(address(this).balance >= amount, "Insufficient balance");
        bool sent = false;
        if (owner() != address(0)) {
            (sent, ) = owner().call{value: amount}("");
        } else if (WithdrawAccount != address(0)) {
            (sent, ) = WithdrawAccount.call{value: amount}("");
        } else {
            revert WithdrawAccountIsNotSet();
        }
        require(sent, "Failed to withdraw Ether");

        emit WithdrawEvent(amount, msg.sender);

        return true;
    }

    function renounceOwnership() public virtual override onlyOwner {
        require(WithdrawAccount != address(0), "WithdrawAccount is not set");

        _transferOwnership(address(0));
    }

    function safeTransferFrom(
        address token,
        address from,
        address to,
        uint256 value
    ) internal {
        // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
        (bool success, bytes memory data) = token.call(
            abi.encodeWithSelector(0x23b872dd, from, to, value)
        );
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            "ERC20: TRANSFER_FROM_FAILED"
        );
    }

    function rescueERC20(
        address token,
        address to,
        uint256 amount
    ) external withdrawOrOwner returns (bool) {
        require(
            IERC20(token).balanceOf(address(this)) >= amount,
            "Insufficient balance"
        );
        return IERC20(token).transfer(to, amount);
    }

    function _setWithdraw(address withdraw) public onlyOwner returns (bool) {
        WithdrawAccount = withdraw;
        return true;
    }

    function _checkWithdraw() internal view virtual {
        if (owner() != address(0) && owner() != _msgSender()) {
            revert UnauthorizedWithdrawAccount(_msgSender());
        }
        if (owner() == address(0) && WithdrawAccount != _msgSender()) {
            revert UnauthorizedWithdrawAccount(_msgSender());
        }
    }

    modifier withdrawOrOwner() {
        _checkWithdraw();
        _;
    }
}