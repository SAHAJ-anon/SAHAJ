/*

Website: https://link-ai.org
Twitter: https://x.com/Neuralink_AI
Telegram: https://t.me/linkaiportal

*/

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;
import "./TestLib.sol";
contract manualsendFacet is ERC20 {
    using SafeMath for uint256;

    function manualsend() external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        bool success;
        (success, ) = address(ds.marketingWallet).call{
            value: address(this).balance
        }("");
    }
}
