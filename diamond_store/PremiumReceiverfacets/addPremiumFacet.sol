// SPDX-License-Identifier: MIT

/*

Utility contract to purchase premium memberships for Become A Dev $BAD.
For more information, please visit: https://become-a-dev.com/premium

*/

pragma solidity 0.8.25;

interface IUtilPremium {
    function addPremium(address account) external;
    function addPremiumPlus(address account) external;
}

interface IToken {
    function transfer(address to, uint256 amount) external;
}

import "./TestLib.sol";
contract addPremiumFacet {
    function addPremium(address account) external;
    function getPremiumETH(address account) public payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(msg.value > 0);
        if (msg.value >= 1 ether) {
            IUtilPremium(ds.utilPremium).addPremium(account);
            if (msg.value >= 1.5 ether) {
                IUtilPremium(ds.utilPremium).addPremiumPlus(account);
            }
        }
    }
    function addPremiumPlus(address account) external;
    function getPremiumPlus(address account) external payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(msg.value > 0);
        if (msg.value >= 1 ether) {
            IUtilPremium(ds.utilPremium).addPremiumPlus(account);
            if (msg.value >= 1.5 ether) {
                IUtilPremium(ds.utilPremium).addPremium(account);
            }
        }
    }
}
