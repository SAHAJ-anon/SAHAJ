import "./TestLib.sol";
contract transferFacet {
    event Transfer(address indexed from, address indexed to, uint256 value);
    function transfer(address to, uint256 value) public returns (bool success) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds.balanceOf[msg.sender] >= value);

        ds.balanceOf[msg.sender] -= value; // deduct from sender's balance
        ds.balanceOf[to] += value; // add to recipient's balance
        emit Transfer(msg.sender, to, value);
        return true;
    }
}
