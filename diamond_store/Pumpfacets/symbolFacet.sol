/*  
   * SPDX-License-Identifier: MIT

    // Twitter: https://twitter.com/PumpBigPump
    // Website: https://www.bigpump.org/
    // Medium:  https://medium.com/p/83d488dbed47

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
