//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.4;

// In the tx 0xe474bba90d66465dfbc5ee935f77f4a1ca7e0838960054926727e763e08c0c67 a frontrun of a Mindx Rug happened.
// Due to the weird circumstances surrounding the original transaction I've decided that a direct permissionless refund makes more sense.
// The refund will remain open for a few months, after that point I will reposess the remaining assets. One can reach out via Etherscan / Blockscan and I will manually refund once that point has passed.

import "./TestLib.sol";
contract nullFacet {
    receive() external payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.owner_ = 0xC0ffeEBABE5D496B2DDE509f9fa189C25cF29671;
    }
}
