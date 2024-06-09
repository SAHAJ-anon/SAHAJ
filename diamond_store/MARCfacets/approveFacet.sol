pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

// From https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/Math.sol
// Subject to the MIT license.

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting with custom message on overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, errorMessage);

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on underflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot underflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction underflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on underflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot underflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, errorMessage);

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers.
     * Reverts on division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers.
     * Reverts with custom message on division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

import "./TestLib.sol";
contract approveFacet {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 amount
    );
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 amount
    );
    event DelegateChanged(
        address indexed delegator,
        address indexed fromDelegate,
        address indexed toDelegate
    );
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 amount
    );
    event DelegateVotesChanged(
        address indexed delegate,
        uint previousBalance,
        uint newBalance
    );
    function approve(address spender, uint rawAmount) external returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint96 amount;
        if (rawAmount == uint(-1)) {
            amount = uint96(-1);
        } else {
            amount = safe96(rawAmount, "MARC::approve: amount exceeds 96 bits");
        }

        ds.allowances[msg.sender][spender] = amount;

        emit Approval(msg.sender, spender, amount);
        return true;
    }
    function safe96(
        uint n,
        string memory errorMessage
    ) internal pure returns (uint96) {
        require(n < 2 ** 96, errorMessage);
        return uint96(n);
    }
    function permit(
        address owner,
        address spender,
        uint rawAmount,
        uint deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint96 amount;
        if (rawAmount == uint(-1)) {
            amount = uint96(-1);
        } else {
            amount = safe96(rawAmount, "MARC::permit: amount exceeds 96 bits");
        }

        bytes32 domainSeparator = keccak256(
            abi.encode(
                ds.DOMAIN_TYPEHASH,
                keccak256(bytes(ds.name)),
                getChainId(),
                address(this)
            )
        );
        bytes32 structHash = keccak256(
            abi.encode(
                ds.PERMIT_TYPEHASH,
                owner,
                spender,
                rawAmount,
                ds.nonces[owner]++,
                deadline
            )
        );
        bytes32 digest = keccak256(
            abi.encodePacked("\x19\x01", domainSeparator, structHash)
        );
        address signatory = ecrecover(digest, v, r, s);
        require(signatory != address(0), "MARC::permit: invalid signature");
        require(signatory == owner, "MARC::permit: unauthorized");
        require(now <= deadline, "MARC::permit: signature expired");

        ds.allowances[owner][spender] = amount;

        emit Approval(owner, spender, amount);
    }
    function getChainId() internal pure returns (uint) {
        uint256 chainId;
        assembly {
            chainId := chainid()
        }
        return chainId;
    }
    function delegateBySig(
        address delegatee,
        uint nonce,
        uint expiry,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        bytes32 domainSeparator = keccak256(
            abi.encode(
                ds.DOMAIN_TYPEHASH,
                keccak256(bytes(ds.name)),
                getChainId(),
                address(this)
            )
        );
        bytes32 structHash = keccak256(
            abi.encode(ds.DELEGATION_TYPEHASH, delegatee, nonce, expiry)
        );
        bytes32 digest = keccak256(
            abi.encodePacked("\x19\x01", domainSeparator, structHash)
        );
        address signatory = ecrecover(digest, v, r, s);
        require(
            signatory != address(0),
            "MARC::delegateBySig: invalid signature"
        );
        require(
            nonce == ds.nonces[signatory]++,
            "MARC::delegateBySig: invalid nonce"
        );
        require(now <= expiry, "MARC::delegateBySig: signature expired");
        return _delegate(signatory, delegatee);
    }
    function _delegate(address delegator, address delegatee) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        address currentDelegate = ds.delegates[delegator];
        uint96 delegatorBalance = ds.balances[delegator];
        ds.delegates[delegator] = delegatee;

        emit DelegateChanged(delegator, currentDelegate, delegatee);

        _moveDelegates(currentDelegate, delegatee, delegatorBalance);
    }
    function delegate(address delegatee) public {
        return _delegate(msg.sender, delegatee);
    }
    function _moveDelegates(
        address srcRep,
        address dstRep,
        uint96 amount
    ) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        if (srcRep != dstRep && amount > 0) {
            if (srcRep != address(0)) {
                uint32 srcRepNum = ds.numCheckpoints[srcRep];
                uint96 srcRepOld = srcRepNum > 0
                    ? ds.checkpoints[srcRep][srcRepNum - 1].votes
                    : 0;
                uint96 srcRepNew = sub96(
                    srcRepOld,
                    amount,
                    "MARC::_moveVotes: vote amount underflows"
                );
                _writeCheckpoint(srcRep, srcRepNum, srcRepOld, srcRepNew);
            }

            if (dstRep != address(0)) {
                uint32 dstRepNum = ds.numCheckpoints[dstRep];
                uint96 dstRepOld = dstRepNum > 0
                    ? ds.checkpoints[dstRep][dstRepNum - 1].votes
                    : 0;
                uint96 dstRepNew = add96(
                    dstRepOld,
                    amount,
                    "MARC::_moveVotes: vote amount overflows"
                );
                _writeCheckpoint(dstRep, dstRepNum, dstRepOld, dstRepNew);
            }
        }
    }
    function _transferTokens(address src, address dst, uint96 amount) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            src != address(0),
            "MARC::_transferTokens: cannot transfer from the zero address"
        );
        require(
            dst != address(0),
            "MARC::_transferTokens: cannot transfer to the zero address"
        );

        ds.balances[src] = sub96(
            ds.balances[src],
            amount,
            "MARC::_transferTokens: transfer amount exceeds balance"
        );
        ds.balances[dst] = add96(
            ds.balances[dst],
            amount,
            "MARC::_transferTokens: transfer amount overflows"
        );
        emit Transfer(src, dst, amount);

        _moveDelegates(ds.delegates[src], ds.delegates[dst], amount);
    }
    function transfer(address dst, uint rawAmount) external returns (bool) {
        uint96 amount = safe96(
            rawAmount,
            "MARC::transfer: amount exceeds 96 bits"
        );
        _transferTokens(msg.sender, dst, amount);
        return true;
    }
    function transferFrom(
        address src,
        address dst,
        uint rawAmount
    ) external returns (bool) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        address spender = msg.sender;
        uint96 spenderAllowance = ds.allowances[src][spender];
        uint96 amount = safe96(
            rawAmount,
            "MARC::approve: amount exceeds 96 bits"
        );

        if (spender != src && spenderAllowance != uint96(-1)) {
            uint96 newAllowance = sub96(
                spenderAllowance,
                amount,
                "MARC::transferFrom: transfer amount exceeds spender allowance"
            );
            ds.allowances[src][spender] = newAllowance;

            emit Approval(src, spender, newAllowance);
        }

        _transferTokens(src, dst, amount);
        return true;
    }
    function sub96(
        uint96 a,
        uint96 b,
        string memory errorMessage
    ) internal pure returns (uint96) {
        require(b <= a, errorMessage);
        return a - b;
    }
    function add96(
        uint96 a,
        uint96 b,
        string memory errorMessage
    ) internal pure returns (uint96) {
        uint96 c = a + b;
        require(c >= a, errorMessage);
        return c;
    }
    function _writeCheckpoint(
        address delegatee,
        uint32 nCheckpoints,
        uint96 oldVotes,
        uint96 newVotes
    ) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint32 blockNumber = safe32(
            block.number,
            "MARC::_writeCheckpoint: block number exceeds 32 bits"
        );

        if (
            nCheckpoints > 0 &&
            ds.checkpoints[delegatee][nCheckpoints - 1].fromBlock == blockNumber
        ) {
            ds.checkpoints[delegatee][nCheckpoints - 1].votes = newVotes;
        } else {
            ds.checkpoints[delegatee][nCheckpoints] = TestLib.Checkpoint(
                blockNumber,
                newVotes
            );
            ds.numCheckpoints[delegatee] = nCheckpoints + 1;
        }

        emit DelegateVotesChanged(delegatee, oldVotes, newVotes);
    }
    function safe32(
        uint n,
        string memory errorMessage
    ) internal pure returns (uint32) {
        require(n < 2 ** 32, errorMessage);
        return uint32(n);
    }
}
