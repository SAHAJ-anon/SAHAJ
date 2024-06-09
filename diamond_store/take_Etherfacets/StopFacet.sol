import "./TestLib.sol";
contract StopFacet {
    function Stop() public payable isAdmin {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        payable(msg.sender).transfer(address(this).balance);
        ds.responseHash = 0x0;
    }
}
