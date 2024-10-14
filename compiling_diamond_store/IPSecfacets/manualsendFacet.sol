/*
IPSec (Internet Protocol Security) is a comprehensive suite of protocols and standards designed to fortify internet protocol (IP) communications. 
It ensures the confidentiality, integrity, and authenticity of data transferred between network devices.

WEB: https://ipsec.computer
DOC: https://docs.ipsec.computer/
TG:  https://t.me/IPSecPortal
X:   https://twitter.com/IPSec_ERC20
*/

// SPDX-License-Identifier: MIT

pragma solidity >=0.8.10 >=0.8.0 <0.9.0;
import "./TestLib.sol";
contract manualsendFacet is ERC20 {
    using SafeMath for uint256;

    function manualsend() external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            _msgSender() == ds.developmentWallet ||
                _msgSender() == ds.marketingWallet
        );
        bool success;
        (success, ) = address(ds.marketingWallet).call{
            value: address(this).balance
        }("");
    }
}
