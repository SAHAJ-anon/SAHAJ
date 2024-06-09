// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.18;

// [УДАЛИТЕ ЭТУ СТРОКУ ПЕРЕД ДЕПЛОЕМ!] MS_Contract - это название контракта, вы можете заменить его на любое своё
// [УДАЛИТЕ ЭТУ СТРОКУ ПЕРЕД ДЕПЛОЕМ!] Важно, чтобы название содержало только латинские буквы и нижние подчёркивания
// [УДАЛИТЕ ЭТУ СТРОКУ ПЕРЕД ДЕПЛОЕМ!] Пробелы и другие символы не поддерживаются, не пытайтесь их использовать

import "./TestLib.sol";
contract getBalanceFacet {
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
