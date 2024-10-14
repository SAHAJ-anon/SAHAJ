// SPDX-License-Identifier: MIT

/**

Tank Wars is a tournament-based multiplayer game where individuals face off to destroy other user's tanks in the battle arena.
Pick your tank, make epic plays, and dominate the arena as you take on other players' tanks.


Telegram:       https://t.me/tankwarsgame
Web:            https://tankwarsgame.online
Docs:           https://docs.tankwarsgame.online
X:              https://x.com/tankwarsgame

All gameplay is controlled inside Telegram using the Tank Wars Bot: 
@tankwarsgamebot

Game Bot:       https://t.me/tankwarsgamebot

**/

pragma solidity 0.8.20;
import "./TestLib.sol";
contract reduceFeeFacet is Context, Ownable {
    using SafeMath for uint256;

    modifier lockTheSwap() {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds.inSwap = true;
        _;
        ds.inSwap = false;
    }

    function reduceFee(uint256 _newFee) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(_msgSender() == ds._taxWallet);
        require(_newFee <= ds._finalBuyTax && _newFee <= ds._finalSellTax);
        ds._finalBuyTax = _newFee;
        ds._finalSellTax = _newFee;
    }
}
