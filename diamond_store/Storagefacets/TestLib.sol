// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * Liebe Rebecca, ich wünsche dir alles Gute für deine Zukunft. Der Text ist mit der Vigenere-Chiffre verschlüsselt.
 * Wenn du den korrekt entschlüsselten Text als Input für die withdraw-Funktion verwendest, wird das Ether auf deinen Account übertragen.
 * Viel Spaß!
 */
library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        address payable owner;
        bytes32 secret_hash;
        string encrypted_test;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
