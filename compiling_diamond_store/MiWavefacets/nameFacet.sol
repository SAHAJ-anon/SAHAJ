// SPDX-License-Identifier: MIT

/*

MiWave - TRANSFORMING BLOCKCHAIN ANALYSIS WITH CUTTING-EDGE AI

Telegram : https://t.me/MiWaveCloud

Website: https://miwave.cloud/

Docs: https://miwave.gitbook.io/docs/

X: https://twitter.com/MiWaveCloud

*/

pragma solidity 0.8.19;
import "./TestLib.sol";
contract nameFacet is Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function name() public pure returns (string memory) {
        return _name;
    }
}
