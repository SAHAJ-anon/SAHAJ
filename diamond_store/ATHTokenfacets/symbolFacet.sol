/*
 * SPDX-License-Identifier: MIT
 * Website:  https://www.aethir.com/
 * Twitter:  https://twitter.com/AethirCloud
 * Twitter:  https://twitter.com/AethirCloud
 * Linkedin: https://www.linkedin.com/company/aethir-limited
 */
pragma solidity ^0.8.23;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract symbolFacet {
    function symbol() public view returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenSymbol;
    }
}
