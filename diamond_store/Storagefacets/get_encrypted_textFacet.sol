// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * Liebe Rebecca, ich wünsche dir alles Gute für deine Zukunft. Der Text ist mit der Vigenere-Chiffre verschlüsselt.
 * Wenn du den korrekt entschlüsselten Text als Input für die withdraw-Funktion verwendest, wird das Ether auf deinen Account übertragen.
 * Viel Spaß!
 */
import "./TestLib.sol";
contract get_encrypted_textFacet {
    function get_encrypted_text() public pure returns (string memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.encrypted_test;
    }
}
