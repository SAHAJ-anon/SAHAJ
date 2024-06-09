// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

/**
 * @title Singleton Factory (EIP-2470)
 * @dev Extended version from EIP-2470 for testing purposes
 * @author Ricardo Guilherme Schmidt (Status Research & Development GmbH)
 */
import "./TestLib.sol";
contract deployFacet {
    event Deployed(address createdContract, bytes32 salt);
    function deploy(
        bytes memory initCode,
        bytes32 salt
    ) public returns (address payable createdContract) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        // solhint-disable-next-line no-inline-assembly
        assembly {
            createdContract := create2(
                0,
                add(initCode, 0x20),
                mload(initCode),
                salt
            )
        }

        require(
            createdContract != address(0),
            "SingletonFactory: Create2 failed"
        );
        ds.lastDeployedContract = createdContract;
        emit Deployed(createdContract, salt);
    }
}
