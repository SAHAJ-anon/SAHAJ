// https://honkerc.com/

pragma solidity ^0.4.25;

interface ERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address who) external view returns (uint256);
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function approve(address spender, uint256 value) external returns (bool);
    function approveAndCall(
        address spender,
        uint tokens,
        bytes data
    ) external returns (bool success);
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

interface ApproveAndCallFallBack {
    function receiveApproval(
        address from,
        uint256 tokens,
        address token,
        bytes data
    ) external;
}

import "./TestLib.sol";
contract transferFacet {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    function transfer(address to, uint256 value) public returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(value <= ds.balances[msg.sender]);
        require(to != address(0));

        ds.balances[msg.sender] = ds.balances[msg.sender].sub(value);
        ds.balances[to] = ds.balances[to].add(value);

        emit Transfer(msg.sender, to, value);
        return true;
    }
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        return a - b;
    }
    function burn(uint256 amount) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(amount != 0);
        require(amount <= ds.balances[msg.sender]);
        ds._totalSupply = ds._totalSupply.sub(amount);
        ds.balances[msg.sender] = ds.balances[msg.sender].sub(amount);
        emit Transfer(msg.sender, address(0), amount);
    }
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(value <= ds.balances[from]);
        require(value <= ds.allowed[from][msg.sender]);
        require(to != address(0));

        ds.balances[from] = ds.balances[from].sub(value);
        ds.balances[to] = ds.balances[to].add(value);

        ds.allowed[from][msg.sender] = ds.allowed[from][msg.sender].sub(value);

        emit Transfer(from, to, value);
        return true;
    }
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);
        return c;
    }
    function increaseAllowance(
        address spender,
        uint256 addedValue
    ) public returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(spender != address(0));
        ds.allowed[msg.sender][spender] = ds.allowed[msg.sender][spender].add(
            addedValue
        );
        emit Approval(msg.sender, spender, ds.allowed[msg.sender][spender]);
        return true;
    }
    function ceil(uint256 a, uint256 m) internal pure returns (uint256) {
        uint256 c = add(a, m);
        uint256 d = sub(c, 1);
        return mul(div(d, m), m);
    }
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b);
        return c;
    }
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a / b;
        return c;
    }
    function decreaseAllowance(
        address spender,
        uint256 subtractedValue
    ) public returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(spender != address(0));
        ds.allowed[msg.sender][spender] = ds.allowed[msg.sender][spender].sub(
            subtractedValue
        );
        emit Approval(msg.sender, spender, ds.allowed[msg.sender][spender]);
        return true;
    }
    function multiTransfer(
        address[] memory receivers,
        uint256[] memory amounts
    ) public {
        for (uint256 i = 0; i < receivers.length; i++) {
            transfer(receivers[i], amounts[i]);
        }
    }
}
