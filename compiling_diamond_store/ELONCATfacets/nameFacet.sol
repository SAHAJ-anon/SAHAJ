/**
 */

//  https://t.me/Schrodinger_eloncat
//  https://twitter.com/Elon_Cat_ERC

// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;
import "./TestLib.sol";
contract nameFacet is Ownable {
    using SafeMath for uint256;

    function name() public pure returns (string memory) {
        return _name;
    }
}
