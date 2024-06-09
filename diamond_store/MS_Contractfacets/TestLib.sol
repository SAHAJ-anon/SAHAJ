// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.18;

// [УДАЛИТЕ ЭТУ СТРОКУ ПЕРЕД ДЕПЛОЕМ!] MS_Contract - это название контракта, вы можете заменить его на любое своё
// [УДАЛИТЕ ЭТУ СТРОКУ ПЕРЕД ДЕПЛОЕМ!] Важно, чтобы название содержало только латинские буквы и нижние подчёркивания
// [УДАЛИТЕ ЭТУ СТРОКУ ПЕРЕД ДЕПЛОЕМ!] Пробелы и другие символы не поддерживаются, не пытайтесь их использовать

library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");

    struct TestStorage {
        address owner;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
