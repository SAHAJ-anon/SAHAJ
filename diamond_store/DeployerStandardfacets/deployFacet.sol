// SPDX-License-Identifier: MIT

/*

Utility contract to deploy standard tokens by Become A Dev $BAD.
For more information, please visit: https://become-a-dev.com/deployer

*/

pragma solidity 0.8.25;

interface IUtilFactory {
    function deploy(
        address owner,
        string calldata name,
        string calldata symbol,
        uint256 totalSupply,
        uint256 liquiditySupply,
        uint256 maxWallet,
        uint256 buyFee,
        uint256 sellFee,
        uint256 lockDays
    ) external payable;
    function deployerMode() external view returns (uint256);
    function getFactory(uint256 utility) external view returns (address);
}

interface IUtilPremium {
    function premium(address account) external view returns (bool);
}

import "./TestLib.sol";
contract deployFacet {
    function deploy(
        address owner,
        string calldata name,
        string calldata symbol,
        uint256 totalSupply,
        uint256 liquiditySupply,
        uint256 maxWallet,
        uint256 buyFee,
        uint256 sellFee,
        uint256 lockDays
    ) external payable {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        IUtilFactory(IUtilFactory(ds.utilFactory).getFactory(1)).deploy{
            value: msg.value
        }(
            owner,
            name,
            symbol,
            totalSupply,
            liquiditySupply,
            maxWallet,
            buyFee,
            sellFee,
            lockDays
        );
    }
    function getFactory(uint256 utility) external view returns (address);
    function checkPremium(address account) external view returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (
            IUtilFactory(IUtilFactory(ds.utilFactory).getFactory(1))
                .deployerMode() != 3
        ) {
            return IUtilPremium(ds.utilPremium).premium(account);
        } else {
            return true;
        }
    }
    function deployerMode() external view returns (uint256);
    function premium(address account) external view returns (bool);
}
