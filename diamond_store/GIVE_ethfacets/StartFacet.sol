import "./TestLib.sol";
contract StartFacet {
    function Start(
        string calldata _question,
        string calldata _response
    ) public payable isAdmin {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (ds.responseHash == 0x0) {
            ds.responseHash = keccak256(abi.encode(_response));
            ds.question = _question;
        }
    }
}
