import "./TestLib.sol";
contract NewFacet {
    function New(
        string calldata _question,
        bytes32 _responseHash
    ) public payable isAdmin {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.question = _question;
        ds.responseHash = _responseHash;
    }
}
