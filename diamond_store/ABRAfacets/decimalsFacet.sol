/*
 * SPDX-License-Identifier: MIT
 * Website: https://www.abra.com/?utm_source=icodrops
 * Facebook: https://www.facebook.com/AbraGlobal
 * Twitter: https://twitter.com/AbraGlobal
 * Reddit: https://www.reddit.com/user/AbraGlobal/
 * Linkedin: https://www.linkedin.com/company/abra/
 * Medium: https://www.abra.com/blog/
 * Youtube: https://www.youtube.com/channel/UCMb7-snlNp7ctSVlpqMbXFw?view_as=subscriber
 */
pragma solidity ^0.8.24;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract decimalsFacet {
    function decimals() public view virtual returns (uint8) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenDecimals;
    }
}
