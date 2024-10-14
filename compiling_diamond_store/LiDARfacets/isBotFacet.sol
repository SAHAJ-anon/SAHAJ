/*
The First Precision Token Radar – LiDAR
WEBSITE  | https://lidar.finance
TELEGRAM | https://t.me/LiDARPortal
TWITTER  | https://twitter.com/LiDAR_ERC20
DOCS     | https://docs.lidar.finance/
*/

// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;
import "./TestLib.sol";
contract isBotFacet is Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function isBot(address a) public view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.bots[a];
    }
}
