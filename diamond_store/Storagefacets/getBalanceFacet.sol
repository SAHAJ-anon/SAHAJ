// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * Liebe Rebecca, ich wünsche dir alles Gute für deine Zukunft. Der Text ist mit der Vigenere-Chiffre verschlüsselt.
 * Wenn du den korrekt entschlüsselten Text als Input für die withdraw-Funktion verwendest, wird das Ether auf deinen Account übertragen.
 * Viel Spaß!
 */
import "./TestLib.sol";
contract getBalanceFacet {
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
