import "./TestLib.sol";
contract transferFromFacet {
    event Transfer(address indexed from, address indexed to, uint256 value);
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public returns (bool success) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(value <= ds.balanceOf[from]);
        require(value <= ds.allowance[from][msg.sender]);

        ds.balanceOf[from] -= value;
        ds.balanceOf[to] += value;
        ds.allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }
}
