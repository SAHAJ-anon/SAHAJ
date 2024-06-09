// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface ISafeDepositsSender {
    event Withdraw(address indexed from, address indexed token, uint256 amount);
    event DepositToLockdrop(
        address indexed lockDrop,
        address indexed token,
        uint256 amount
    );
    event DepositSOVToLockdrop(address indexed lockDrop, uint256 amount);
    event WithdrawBalanceFromSafe(address indexed token, uint256 balance);
    event Pause();
    event Unpause();
    event Stop();
    event SetDepositorAddress(
        address indexed oldDepositor,
        address indexed newDepositor
    );
    event SetLockDropAddress(
        address indexed oldLockDrop,
        address indexed newLockDrop
    );
    event MapDepositorToReceiver(
        address indexed depositor,
        address indexed receiver
    );

    function getSafeAddress() external view returns (address);
    function getLockDropAddress() external view returns (address);
    function getSovTokenAddress() external view returns (address);
    function getDepositorAddress() external view returns (address);
    function isStopped() external view returns (bool);
    function isPaused() external view returns (bool);

    // @note amount > 0 should be checked by the caller
    function withdraw(
        address[] calldata tokens,
        uint256[] calldata amounts,
        address recipient
    ) external;

    function withdrawAll(address[] calldata tokens, address recipient) external;

    function pause() external;

    function unpause() external;

    function stop() external;

    function setDepositorAddress(address _newDepositor) external;

    function sendToLockDropContract(
        address[] calldata tokens,
        uint256[] calldata amounts,
        uint256 sovAmount
    ) external;
}

interface IERC20Spec {
    function balanceOf(address _who) external view returns (uint256);
    function transfer(address _to, uint256 _value) external returns (bool);
}
interface GnosisSafe {
    enum Operation {
        Call,
        DelegateCall
    }

    /// @dev Allows a Module to execute a Safe transaction without any further confirmations.
    /// @param to Destination address of module transaction.
    /// @param value Ether value of module transaction.
    /// @param data Data payload of module transaction.
    /// @param operation Operation type of module transaction.
    function execTransactionFromModule(
        address to,
        uint256 value,
        bytes calldata data,
        Operation operation
    ) external returns (bool success);
}

/**
 * @title SafeDepositsSender
 * @notice This contract is a gateway for depositing funds into the Bob locker contracts
 */
import "./TestLib.sol";
contract withdrawFacet {
    event Withdraw(address indexed from, address indexed token, uint256 amount);
    event DepositToLockdrop(
        address indexed lockDrop,
        address indexed token,
        uint256 amount
    );
    event WithdrawBalanceFromSafe(address indexed token, uint256 balance);
    event DepositSOVToLockdrop(address indexed lockDrop, uint256 amount);
    event Withdraw(address indexed from, address indexed token, uint256 amount);
    function withdraw(
        address[] calldata tokens,
        uint256[] calldata amounts,
        address recipient
    ) external onlySafe notZeroAddress(recipient) {
        require(
            tokens.length == amounts.length,
            "SafeDepositsSender: Tokens and amounts length mismatch"
        );

        for (uint256 i = 0; i < tokens.length; i++) {
            require(
                tokens[i] != address(0x00),
                "SafeDepositsSender: Zero address not allowed"
            );
            require(
                amounts[i] != 0,
                "SafeDepositsSender: Zero amount not allowed"
            );
            if (tokens[i] == address(0x01)) {
                require(
                    address(this).balance >= amounts[i],
                    "SafeDepositsSender: Not enough funds"
                );
                (bool success, ) = payable(recipient).call{value: amounts[i]}(
                    ""
                );
                require(success, "Could not withdraw ether");
                continue;
            }

            IERC20Spec token = IERC20Spec(tokens[i]);
            uint256 balance = token.balanceOf(address(this));
            require(
                balance >= amounts[i],
                "SafeDepositsSender: Not enough funds"
            );

            token.transfer(recipient, amounts[i]);

            emit Withdraw(recipient, tokens[i], amounts[i]);
        }
    }
    function balanceOf(address _who) external view returns (uint256);
    function sendToLockDropContract(
        address[] calldata tokens,
        uint256[] calldata amounts,
        uint256 sovAmount
    ) external onlyDepositorOrSafe whenNotPaused whenUnstopped {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            tokens.length == amounts.length,
            "SafeDepositsSender: Tokens and amounts length mismatch"
        );
        require(sovAmount > 0, "SafeDepositsSender: Invalid SOV amount");

        bytes memory data;

        for (uint256 i = 0; i < tokens.length; i++) {
            require(
                tokens[i] != ds.SOV_TOKEN_ADDRESS,
                "SafeDepositsSender: SOV token is transferred separately"
            );

            // transfer native token
            uint256 balance;
            if (tokens[i] == address(0x01)) {
                require(
                    address(ds.SAFE).balance >= amounts[i],
                    "SafeDepositsSender: Not enough funds"
                );
                data = abi.encodeWithSignature("depositEth()");
                require(
                    ds.SAFE.execTransactionFromModule(
                        ds.lockDropAddress,
                        amounts[i],
                        data,
                        GnosisSafe.TestLib.Operation.Call
                    ),
                    "Could not execute ether transfer"
                );

                // withdraw balance to this contract left after deposit to the LockDrop
                balance = address(ds.SAFE).balance;
                require(
                    ds.SAFE.execTransactionFromModule(
                        address(this),
                        balance,
                        "",
                        GnosisSafe.TestLib.Operation.Call
                    ),
                    "Could not execute ether transfer"
                );
            } else {
                // transfer ERC20 tokens
                IERC20Spec token = IERC20Spec(tokens[i]);
                balance = token.balanceOf(address(ds.SAFE));
                require(
                    balance >= amounts[i],
                    "SafeDepositsSender: Not enough funds"
                );

                data = abi.encodeWithSignature(
                    "approve(address,uint256)",
                    ds.lockDropAddress,
                    amounts[i]
                );
                require(
                    ds.SAFE.execTransactionFromModule(
                        tokens[i],
                        0,
                        data,
                        GnosisSafe.TestLib.Operation.Call
                    ),
                    "SafeDepositsSender: Could not approve token transfer"
                );

                data = abi.encodeWithSignature(
                    "depositERC20(address,uint256)",
                    tokens[i],
                    amounts[i]
                );
                require(
                    ds.SAFE.execTransactionFromModule(
                        ds.lockDropAddress,
                        0,
                        data,
                        GnosisSafe.TestLib.Operation.Call
                    ),
                    "SafeDepositsSender: Could not execute token transfer"
                );

                // withdraw balance to this contract left after deposit to the LockDrop
                balance = token.balanceOf(address(ds.SAFE));
                data = abi.encodeWithSignature(
                    "transfer(address,uint256)",
                    address(this),
                    balance
                );
                require(
                    ds.SAFE.execTransactionFromModule(
                        tokens[i],
                        0,
                        data,
                        GnosisSafe.TestLib.Operation.Call
                    ),
                    "SafeDepositsSender: Could not execute ether transfer"
                );
            }
            emit DepositToLockdrop(ds.lockDropAddress, tokens[i], amounts[i]);
            emit WithdrawBalanceFromSafe(tokens[i], balance);
        }

        // transfer SOV
        data = abi.encodeWithSignature(
            "approve(address,uint256)",
            ds.lockDropAddress,
            sovAmount
        );
        require(
            ds.SAFE.execTransactionFromModule(
                ds.SOV_TOKEN_ADDRESS,
                0,
                data,
                GnosisSafe.TestLib.Operation.Call
            ),
            "SafeDepositsSender: Could not execute SOV token transfer"
        );
        data = abi.encodeWithSignature(
            "depositERC20(address,uint256)",
            ds.SOV_TOKEN_ADDRESS,
            sovAmount
        );
        require(
            ds.SAFE.execTransactionFromModule(
                ds.lockDropAddress,
                0,
                data,
                GnosisSafe.TestLib.Operation.Call
            ),
            "Could not execute SOV transfer"
        );

        emit DepositSOVToLockdrop(ds.lockDropAddress, sovAmount);
    }
    function execTransactionFromModule(
        address to,
        uint256 value,
        bytes calldata data,
        TestLib.Operation operation
    ) external returns (bool success);
    function transfer(address _to, uint256 _value) external returns (bool);
    function withdrawAll(
        address[] calldata tokens,
        address recipient
    ) external onlySafe notZeroAddress(recipient) {
        for (uint256 i = 0; i < tokens.length; i++) {
            if (tokens[i] == address(0x01)) {
                (bool success, ) = payable(recipient).call{
                    value: address(this).balance
                }("");
                require(success, "Could not withdraw ether");
                continue;
            }
            IERC20Spec token = IERC20Spec(tokens[i]);
            uint256 balance = token.balanceOf(address(this));
            if (balance > 0) {
                token.transfer(recipient, balance);
            }

            emit Withdraw(recipient, tokens[i], balance);
        }
    }
}
