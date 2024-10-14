/*
 * SPDX-License-Identifier: MIT
 * Telegram Channel: https://t.me/xpad_channel
 * Telegram Group (EN): https://t.me/xpad_group
 * Telegram Group (SNG): https://t.me/xpad_sng
 * Twitter: https://twitter.com/Xpad_pro
 * Reddit: https://www.reddit.com/r/xpad_pro
 * Linkedin: https://www.linkedin.com/company/xpadpro
 * Discord: https://discord.gg/g7XTZzCy8G
 * Medium: https://medium.com/@xpad.pro
 */
pragma solidity ^0.8.20;
import "./TestLib.sol";
contract totalSupplyFacet {
    function totalSupply() public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.tokenTotalSupply;
    }
}
