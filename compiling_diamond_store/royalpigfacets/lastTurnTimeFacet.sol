// SPDX-License-Identifier: MIT
// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.20;
import "./TestLib.sol";
contract lastTurnTimeFacet {
    function lastTurnTime() external view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.last_turnTime;
    }
}
