// SPDX-License-Identifier: UNLICENSED

/*  W3B Frens is a pioneering company in the field of NFT IP Licensing.
 *   W3B Frens specializes in facilitating the licensing of intellectual property (IP) rights
 *   through the use of non-fungible tokens (NFTs).
 */

pragma solidity ^0.8.0;

import "./TestLib.sol";
contract getBlackListStatusFacet {
    function getBlackListStatus(address _maker) external view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.isBlackListed[_maker];
    }
}
