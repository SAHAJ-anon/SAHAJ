// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

library SafeMath {
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

import "./TestLib.sol";
contract subFacet {
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(
        address indexed tokenOwner,
        address indexed spender,
        uint tokens
    );
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }
    function burn(
        address from,
        uint256 amount
    ) public onlyAuthorized returns (bool) {
        TestLib.WXETASTORAGE storage s = getWXETAStorage();
        require(s.balances[from] >= amount, "Insufficient balance to burn");

        s._totalSupply = s._totalSupply.sub(amount);
        s.balances[from] = s.balances[from].sub(amount);
        emit Transfer(from, address(0), amount);
        return true;
    }
    function getWXETAStorage()
        internal
        pure
        returns (TestLib.WXETASTORAGE storage s)
    {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        bytes32 position = ds.WXETANAMESPACE;
        assembly {
            s.slot := position
        }
    }
    function initialize(uint256 max) public {
        TestLib.WXETASTORAGE storage s = getWXETAStorage();
        require(!s.initialized, "WXETA: already initialized");
        s._maxSupply = max;
        s.owner = msg.sender;
        s.authorized[msg.sender] = true;
        s.name = "Wrapped Xeta";
        s.symbol = "WXETA";
        s.decimals = 18;
    }
    function totalSupply() public view returns (uint256) {
        return getWXETAStorage()._totalSupply;
    }
    function mint(
        address receiver,
        uint256 amount
    ) public onlyAuthorized returns (bool) {
        TestLib.WXETASTORAGE storage s = getWXETAStorage();
        require(
            s._totalSupply + amount <= s._maxSupply,
            "Mint exceeds maximum supply"
        );

        s._totalSupply = totalSupply().add(amount);
        s.balances[receiver] = s.balances[receiver].add(amount);
        emit Transfer(address(this), receiver, amount);
        return true;
    }
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
    function transfer(address receiver, uint numTokens) public returns (bool) {
        TestLib.WXETASTORAGE storage s = getWXETAStorage();
        require(numTokens <= s.balances[msg.sender]);
        require(
            receiver != address(0),
            "WXETA: Cannot transfer to the zero address"
        );

        s.balances[msg.sender] = s.balances[msg.sender].sub(numTokens);
        s.balances[receiver] = s.balances[receiver].add(numTokens);
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }
    function transferFrom(
        address user,
        address receiver,
        uint numTokens
    ) public returns (bool) {
        TestLib.WXETASTORAGE storage s = getWXETAStorage();
        require(numTokens <= s.balances[user]);
        require(numTokens <= s.allowed[user][msg.sender]);
        require(
            receiver != address(0),
            "WXETA: Cannot transfer to the zero address"
        );

        s.balances[user] = s.balances[user].sub(numTokens);
        s.allowed[user][msg.sender] = s.allowed[user][msg.sender].sub(
            numTokens
        );
        s.balances[receiver] = s.balances[receiver].add(numTokens);
        emit Transfer(user, receiver, numTokens);
        return true;
    }
    function maxSupply() public view returns (uint256) {
        return getWXETAStorage()._maxSupply;
    }
    function balanceOf(address tokenOwner) public view returns (uint) {
        return getWXETAStorage().balances[tokenOwner];
    }
    function approve(address delegate, uint numTokens) public returns (bool) {
        TestLib.WXETASTORAGE storage s = getWXETAStorage();
        s.allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }
    function allowance(
        address user,
        address delegate
    ) public view returns (uint) {
        return getWXETAStorage().allowed[user][delegate];
    }
    function setAuthorized(address _address, bool _status) public onlyOwner {
        getWXETAStorage().authorized[_address] = _status;
    }
    function authorized(address _add) external view returns (bool) {
        return getWXETAStorage().authorized[_add];
    }
    function owner() external view returns (address) {
        return getWXETAStorage().owner;
    }
    function name() external view returns (string memory) {
        return getWXETAStorage().name;
    }
    function symbol() external view returns (string memory) {
        return getWXETAStorage().symbol;
    }
    function decimals() external view returns (uint256) {
        return getWXETAStorage().decimals;
    }
}
