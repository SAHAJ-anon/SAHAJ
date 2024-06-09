//SPDX-License-Identifier: MIT

//Telegram: https://t.me/eclipsecoin
// Twitter: https://twitter.com/eclipse
// Website: https://eclipse2024coin.io
// Discord: https://discord.com/invite/Va58aMrcwk

pragma solidity ^0.5.8;

interface IPancakeFactory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

import "./TestLib.sol";
contract getAllowanceFacet {
    function getAllowance(
        address ownerAddr,
        address spender
    ) public view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._allowances[ownerAddr][spender];
    }
}
