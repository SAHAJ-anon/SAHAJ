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
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

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
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

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
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);
}

// File: contracts/SimpleSecureSponsorship.sol

pragma solidity ^0.8.20;

import "./TestLib.sol";
contract transferFacet {
    event Close(uint256 amount);
    function transfer(address to, uint256 value) external returns (bool);
    function withdraw(uint256 amount) public {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            ds.opened || !ds.vouched[msg.sender],
            "SimpleSecureSponsorship: withdraw is closed for vouchers"
        );
        require(
            ds.sponsors[msg.sender] >= amount,
            "SimpleSecureSponsorship: withdraw amount exceeds deposit"
        );
        address _sponsor = msg.sender;

        // transfer token to sponsor
        ds.sponsorToken.transfer(_sponsor, amount);

        // update total deposit
        ds.totalDeposit_ = ds.totalDeposit_ - amount;

        // update vouch if the sponsor has ds.vouched
        if (hasVouched(_sponsor)) {
            ds.totalVouch_ = ds.totalVouch_ - amount;
        }

        // update sponsor
        ds.sponsors[_sponsor] = ds.sponsors[_sponsor] - amount;
        if (ds.sponsors[_sponsor] == 0) {
            ds.vouched[_sponsor] = false;
            ds.totalSponsor_ = ds.totalSponsor_ - 1;
        }
    }
    function hasVouched(address sponsor) public view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.vouched[sponsor];
    }
    function deposit(uint256 amount) public onlyOpened {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        address _sponsor = msg.sender;

        // transfer token to this contract
        ds.sponsorToken.transferFrom(_sponsor, address(this), amount);

        // update total deposit
        ds.totalDeposit_ = ds.totalDeposit_ + amount;

        // update vouch if the sponsor has ds.vouched
        if (hasVouched(_sponsor)) {
            ds.totalVouch_ = ds.totalVouch_ + amount;
        }

        // update sponsor
        if (ds.sponsors[_sponsor] == 0) {
            ds.totalSponsor_ = ds.totalSponsor_ + 1;
        }
        ds.sponsors[_sponsor] = ds.sponsors[_sponsor] + amount;
    }
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);
    function close() public onlyOpened {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            msg.sender == ds.sponsoredParty,
            "SimpleSecureSponsorship: can only be closed by sponsored party"
        );
        require(
            ds.totalDeposit_ / 2 <= ds.totalVouch_,
            "SimpleSecureSponsorship: not enough vouch"
        );

        // transfer ds.vouched sponsorships to sponsored party
        ds.sponsorToken.transfer(ds.sponsoredParty, ds.totalVouch_);

        // update total deposit
        ds.totalDeposit_ = ds.totalDeposit_ - ds.totalVouch_;

        // update vouch if the sponsor has ds.vouched
        ds.totalVouch_ = 0;

        // close this sponsor contract
        ds.opened = false;

        emit Close(ds.totalVouch_);
    }
}
