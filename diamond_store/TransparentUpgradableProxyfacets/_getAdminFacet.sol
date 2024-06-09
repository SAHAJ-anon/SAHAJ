// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.24;

/**
 * @dev This contract implements a proxy that is upgradeable by an admin.
 *
 * https://blog.openzeppelin.com/the-transparent-proxy-pattern/[transparent proxy pattern]. This pattern implies two
 * things that go hand in hand:
 *
 * 1. If any account other than the admin calls the proxy, the call will be forwarded to the implementation, even if
 * that call matches one of the admin functions exposed by the proxy itself.
 * 2. If the admin calls the proxy, it can access the admin functions, but its calls will never be forwarded to the
 * implementation. If the admin tries to call a function on the implementation it will fail with an error that says
 * "admin cannot fallback to proxy target".
 *
 * These properties mean that the admin account can only be used for admin actions like upgrading the proxy or changing
 * the admin, so it's best if it's a dedicated account that is not used for anything else. This will avoid headaches due
 * to sudden errors when trying to call a function from the proxy implementation.
 *
 * Our recommendation is for the dedicated account to be an instance of the {ProxyAdmin} contract. If set up this way,
 * you should think of the `ProxyAdmin` instance as the real administrative interface of your proxy.
 */
import "./TestLib.sol";
contract _getAdminFacet {
    function _getAdmin() private view returns (address) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return StorageSlot.getAddressSlot(ds.ADMIN_SLOT).value;
    }
    function getAddressSlot(
        bytes32 slot
    ) internal pure returns (TestLib.AddressSlot storage r) {
        assembly {
            r.slot := slot
        }
    }
    function _setAdmin(address _admin) private {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(_admin != address(0), "admin = zero address");
        StorageSlot.getAddressSlot(ds.ADMIN_SLOT).value = _admin;
    }
    function changeAdmin(address _admin) external ifAdmin {
        _setAdmin(_admin);
    }
    function _getImplementation() private view returns (address) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return StorageSlot.getAddressSlot(ds.IMPLEMENTATION_SLOT).value;
    }
    function implementation() external ifAdmin returns (address) {
        return _getImplementation();
    }
    function _fallback() private {
        _delegate(_getImplementation());
    }
    function _delegate(address _implementation) internal {
        assembly {
            // Copy msg.data. We take full control of memory in this inline assembly
            // block because it will not return to Solidity code. We overwrite the
            // Solidity scratch pad at memory position 0.

            // calldatacopy(t, f, s) - copy s bytes from calldata at position f to mem at position t
            // calldatasize() - size of call data in bytes
            calldatacopy(0, 0, calldatasize())

            // Call the implementation.
            // out and outsize are 0 because we don't know the size yet.

            // delegatecall(g, a, in, insize, out, outsize) -
            // - call contract at address a
            // - with input mem[in…(in+insize))
            // - providing g gas
            // - and output area mem[out…(out+outsize))
            // - returning 0 on error (eg. out of gas) and 1 on success
            let result := delegatecall(
                gas(),
                _implementation,
                0,
                calldatasize(),
                0,
                0
            )

            // Copy the returned data.
            // returndatacopy(t, f, s) - copy s bytes from returndata at position f to mem at position t
            // returndatasize() - size of the last returndata
            returndatacopy(0, 0, returndatasize())

            switch result
            // delegatecall returns 0 on error.
            case 0 {
                // revert(p, s) - end execution, revert state changes, return data mem[p…(p+s))
                revert(0, returndatasize())
            }
            default {
                // return(p, s) - end execution, return data mem[p…(p+s))
                return(0, returndatasize())
            }
        }
    }
    function _setImplementation(address _implementation) private {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            _implementation.code.length > 0,
            "implementation is not contract"
        );
        StorageSlot
            .getAddressSlot(ds.IMPLEMENTATION_SLOT)
            .value = _implementation;
    }
    function upgradeTo(address _implementation) external ifAdmin {
        _setImplementation(_implementation);
    }
    function upgradeToAndCall(
        address _implementation,
        bytes memory data
    ) external ifAdmin {
        require(
            _implementation.code.length > 0,
            "Invalid implementation address"
        );
        _setImplementation(_implementation);

        if (data.length > 0) {
            _implementation.delegatecall(data);
        }
    }
    function admin() external ifAdmin returns (address) {
        return _getAdmin();
    }
}
