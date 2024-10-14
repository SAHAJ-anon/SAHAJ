// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;
import "./TestLib.sol";
contract getMaxWalletFacet {
    modifier inSwapFlag() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }
    modifier onlyOwner() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(ds._owner == msg.sender, "Caller =/= owner.");
        _;
    }

    function getMaxWallet() external view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._maxWalletSize / (10 ** _decimals);
    }
}
