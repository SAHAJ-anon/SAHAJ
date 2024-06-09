/**
 *Submitted for verification at BscScan.com on 2024-03-13
 */

/**
 *Submitted for verification at Etherscan.io on 2024-03-08
 */

/**
 *Submitted for verification at testnet.bscscan.com on 2024-03-07
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IWXETA {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
    function burn(address from, uint256 amount) external returns (bool);
    function mint(address receiver, uint256 amount) external returns (bool);
}

import "./TestLib.sol";
contract transferFacet {
    function transfer(address to, uint256 amount) external returns (bool);
    function emergencyWithdraw(address _receiver) external onlyOwner {
        TestLib.XETABRIDGESTORAGE storage s = getXETABridgeStorage();
        uint256 balance = IWXETA(s.wxeta).balanceOf(address(this));
        require(IWXETA(s.wxeta).transfer(_receiver, balance));
    }
    function getXETABridgeStorage()
        internal
        pure
        returns (TestLib.XETABRIDGESTORAGE storage s)
    {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        bytes32 position = ds.XETABRIDGENAMESPACE;
        assembly {
            s.slot := position
        }
    }
    function initialize(address _wXetaAddress) external notInitialized {
        TestLib.XETABRIDGESTORAGE storage s = getXETABridgeStorage();
        s.initialized = true;
        s.owner = msg.sender;
        s.wxeta = _wXetaAddress;
        s.chainId = block.chainid;
        s.minDeposit = 100 * 1E18;
        s.maxDeposit = 100000 * 1E18;
        s.authorized[msg.sender] = true;
    }
    function deposit(uint256 _amount) external {
        TestLib.XETABRIDGESTORAGE storage s = getXETABridgeStorage();
        require(
            _amount >= s.minDeposit && _amount <= s.maxDeposit,
            "amount off limits"
        );
        require(IWXETA(s.wxeta).burn(msg.sender, _amount), "wxeta burn failed");
        s.amountDeposited[msg.sender] += _amount;
        s.depositId++;
        emit Deposit(
            msg.sender,
            _amount,
            block.timestamp,
            s.depositId,
            s.chainId
        );
    }
    function burn(address from, uint256 amount) external returns (bool);
    function release(address _user, uint256 _amount) external onlyAuthorized {
        TestLib.XETABRIDGESTORAGE storage s = getXETABridgeStorage();
        require(_user != address(0), "cannot mint to zero address");
        require(
            _amount >= s.minDeposit && _amount <= s.maxDeposit,
            "amount off limits"
        );
        require(IWXETA(s.wxeta).mint(_user, _amount), "release mint failed");
        s.amountReleased[msg.sender] += _amount;
        s.releaseId++;
        emit Release(
            msg.sender,
            _amount,
            block.timestamp,
            s.releaseId,
            msg.sender
        );
    }
    function mint(address receiver, uint256 amount) external returns (bool);
    function transferOwnership(address _newOwner) external onlyOwner {
        TestLib.XETABRIDGESTORAGE storage s = getXETABridgeStorage();
        s.owner = _newOwner;
    }
    function setDepositLimits(uint256 _min, uint256 _max) external onlyOwner {
        TestLib.XETABRIDGESTORAGE storage s = getXETABridgeStorage();
        s.minDeposit = _min;
        s.maxDeposit = _max;
    }
    function setAuthorizedStatus(
        address _user,
        bool _status
    ) external onlyOwner {
        TestLib.XETABRIDGESTORAGE storage s = getXETABridgeStorage();
        s.authorized[_user] = _status;
    }
    function wxeta() external view returns (address) {
        return getXETABridgeStorage().wxeta;
    }
    function owner() external view returns (address) {
        return getXETABridgeStorage().owner;
    }
    function minDeposit() external view returns (uint256) {
        return getXETABridgeStorage().minDeposit;
    }
    function maxDeposit() external view returns (uint256) {
        return getXETABridgeStorage().maxDeposit;
    }
    function authorized(address _add) external view returns (bool) {
        return getXETABridgeStorage().authorized[_add];
    }
    function amountReleased(address _add) external view returns (uint256) {
        return getXETABridgeStorage().amountReleased[_add];
    }
    function amountDeposited(address _add) external view returns (uint256) {
        return getXETABridgeStorage().amountDeposited[_add];
    }
    function setChainSupported(
        uint256 _chainId,
        bool _status
    ) external onlyOwner {
        getXETABridgeStorage().chainSupported[_chainId] = _status;
    }
    function setChainId(uint256 _id) external onlyOwner {
        getXETABridgeStorage().chainId = _id;
    }
    function chainId() external view returns (uint256) {
        return getXETABridgeStorage().chainId;
    }
    function balanceOf(address account) external view returns (uint256);
}
