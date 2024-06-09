import "./TestLib.sol";
contract divisionFacet {
    function division(uint256 x, uint256 y) internal pure returns (uint256 z) {
        z = (x + (y / 2)) / y;
    }
    function convertWadToAssetDecimals(
        uint256 value,
        uint256 assetDecimals
    ) internal pure returns (uint256) {
        if (assetDecimals == 18) {
            return value;
        } else if (assetDecimals > 18) {
            return value * 10 ** (assetDecimals - 18);
        } else {
            return division(value, 10 ** (18 - assetDecimals));
        }
    }
    function convertToWad(
        uint256 value,
        uint256 assetDecimals
    ) internal pure returns (uint256) {
        if (value > 0) {
            if (assetDecimals == 18) {
                return value;
            } else if (assetDecimals > 18) {
                return division(value, 10 ** (assetDecimals - 18));
            } else {
                return value * 10 ** (18 - assetDecimals);
            }
        } else {
            return value;
        }
    }
    function percentOf(
        uint256 value,
        uint256 rate
    ) internal pure returns (uint256) {
        return division(value * rate, 1e18);
    }
    function addContinuousCompoundInterestUsingRatePeriodMultiplication(
        uint256 value,
        uint256 interestRatePeriodMultiplication
    ) internal pure returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        uint256 interestRateYearsMultiplication = IporMath.division(
            interestRatePeriodMultiplication,
            Constants.ds.YEAR_IN_SECONDS
        );
        bytes16 floatValue = _toQuadruplePrecision(value, 1e18);
        bytes16 floatIpm = _toQuadruplePrecision(
            interestRateYearsMultiplication,
            1e18
        );
        bytes16 valueWithInterest = ABDKMathQuad.mul(
            floatValue,
            ABDKMathQuad.exp(floatIpm)
        );
        return _toUint256(valueWithInterest);
    }
    function _toQuadruplePrecision(
        uint256 number,
        uint256 decimals
    ) private pure returns (bytes16) {
        if (number % decimals > 0) {
            /// @dev during calculation this value is lost in the conversion
            number += 1;
        }
        bytes16 nominator = ABDKMathQuad.fromUInt(number);
        bytes16 denominator = ABDKMathQuad.fromUInt(decimals);
        bytes16 fraction = ABDKMathQuad.div(nominator, denominator);
        return fraction;
    }
    function fromUInt(uint256 x) internal pure returns (bytes16) {
        unchecked {
            if (x == 0) return bytes16(0);
            else {
                uint256 result = x;

                uint256 msb = mostSignificantBit(result);
                if (msb < 112) result <<= 112 - msb;
                else if (msb > 112) result >>= msb - 112;

                result =
                    (result & 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF) |
                    ((16383 + msb) << 112);

                return bytes16(uint128(result));
            }
        }
    }
    function mostSignificantBit(uint256 x) private pure returns (uint256) {
        unchecked {
            require(x > 0);

            uint256 result = 0;

            if (x >= 0x100000000000000000000000000000000) {
                x >>= 128;
                result += 128;
            }
            if (x >= 0x10000000000000000) {
                x >>= 64;
                result += 64;
            }
            if (x >= 0x100000000) {
                x >>= 32;
                result += 32;
            }
            if (x >= 0x10000) {
                x >>= 16;
                result += 16;
            }
            if (x >= 0x100) {
                x >>= 8;
                result += 8;
            }
            if (x >= 0x10) {
                x >>= 4;
                result += 4;
            }
            if (x >= 0x4) {
                x >>= 2;
                result += 2;
            }
            if (x >= 0x2) result += 1; // No need to shift x anymore

            return result;
        }
    }
    function fromInt(int256 x) internal pure returns (bytes16) {
        unchecked {
            if (x == 0) return bytes16(0);
            else {
                // We rely on overflow behavior here
                uint256 result = uint256(x > 0 ? x : -x);

                uint256 msb = mostSignificantBit(result);
                if (msb < 112) result <<= 112 - msb;
                else if (msb > 112) result >>= msb - 112;

                result =
                    (result & 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF) |
                    ((16383 + msb) << 112);
                if (x < 0) result |= 0x80000000000000000000000000000000;

                return bytes16(uint128(result));
            }
        }
    }
    function _toQuadruplePrecisionInt(
        int256 number,
        int256 decimals
    ) private pure returns (bytes16) {
        if (number % decimals > 0) {
            /// @dev during calculation this value is lost in the conversion
            number += 1;
        }
        bytes16 nominator = ABDKMathQuad.fromInt(number);
        bytes16 denominator = ABDKMathQuad.fromInt(decimals);
        bytes16 fraction = ABDKMathQuad.div(nominator, denominator);
        return fraction;
    }
    function addContinuousCompoundInterestUsingRatePeriodMultiplicationInt(
        int256 value,
        int256 interestRatePeriodMultiplication
    ) internal pure returns (int256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        int256 interestRateYearsMultiplication = IporMath.divisionInt(
            interestRatePeriodMultiplication,
            Constants.ds.YEAR_IN_SECONDS.toInt256()
        );
        bytes16 floatValue = _toQuadruplePrecisionInt(value, 1e18);
        bytes16 floatIpm = _toQuadruplePrecisionInt(
            interestRateYearsMultiplication,
            1e18
        );
        bytes16 valueWithInterest = ABDKMathQuad.mul(
            floatValue,
            ABDKMathQuad.exp(floatIpm)
        );
        return _toInt256(valueWithInterest);
    }
    function divisionInt(int256 x, int256 y) internal pure returns (int256 z) {
        uint256 absX = uint256(x < 0 ? -x : x);
        uint256 absY = uint256(y < 0 ? -y : y);

        // Use bitwise XOR to get the sign on MBS bit then shift to LSB
        // sign == 0x0000...0000 ==  0 if the number is non-negative
        // sign == 0xFFFF...FFFF == -1 if the number is negative
        int256 sign = (x ^ y) >> 255;

        uint256 divAbs;
        uint256 remainder;

        unchecked {
            divAbs = absX / absY;
            remainder = absX % absY;
        }
        // Check if we need to round
        if (sign < 0) {
            // remainder << 1 left shift is equivalent to multiplying by 2
            if (remainder << 1 > absY) {
                ++divAbs;
            }
        } else {
            if (remainder << 1 >= absY) {
                ++divAbs;
            }
        }

        // (sign | 1) is cheaper than (sign < 0) ? -1 : 1;
        unchecked {
            z = int256(divAbs) * (sign | 1);
        }
    }
    function toInt256(uint256 value) internal pure returns (int256) {
        // Note: Unsafe cast below is okay because `type(int256).max` is guaranteed to be positive
        require(
            value <= uint256(type(int256).max),
            "SafeCast: value doesn't fit in an int256"
        );
        return int256(value);
    }
    function calculateSoapPayFixed(
        AmmStorageTypes.TestLib.SoapIndicators memory si,
        uint256 calculateTimestamp,
        uint256 ibtPrice
    ) internal pure returns (int256) {
        return
            IporMath.division(si.totalIbtQuantity * ibtPrice, 1e18).toInt256() -
            (si.totalNotional +
                calculateHyphoteticalInterestTotal(si, calculateTimestamp))
                .toInt256();
    }
    function calculateHyphoteticalInterestTotal(
        AmmStorageTypes.TestLib.SoapIndicators memory si,
        uint256 calculateTimestamp
    ) internal pure returns (uint256) {
        return
            si.hypotheticalInterestCumulative +
            calculateHypotheticalInterestDelta(
                calculateTimestamp,
                si.rebalanceTimestamp,
                si.totalNotional + si.hypotheticalInterestCumulative,
                si.averageInterestRate
            );
    }
    function calculateSoapReceiveFixed(
        AmmStorageTypes.TestLib.SoapIndicators memory si,
        uint256 calculateTimestamp,
        uint256 ibtPrice
    ) internal pure returns (int256) {
        return
            (si.totalNotional +
                calculateHyphoteticalInterestTotal(si, calculateTimestamp))
                .toInt256() -
            IporMath.division(si.totalIbtQuantity * ibtPrice, 1e18).toInt256();
    }
    function calculateHypotheticalInterestDelta(
        uint256 calculateTimestamp,
        uint256 lastRebalanceTimestamp,
        uint256 totalNotional,
        uint256 averageInterestRate
    ) internal pure returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            calculateTimestamp >= lastRebalanceTimestamp,
            AmmErrors.ds.CALC_TIMESTAMP_LOWER_THAN_SOAP_REBALANCE_TIMESTAMP
        );
        return
            totalNotional
                .calculateContinuousCompoundInterestUsingRatePeriodMultiplication(
                    averageInterestRate *
                        (calculateTimestamp - lastRebalanceTimestamp)
                );
    }
    function calculateContinuousCompoundInterestUsingRatePeriodMultiplication(
        uint256 value,
        uint256 interestRatePeriodMultiplication
    ) internal pure returns (uint256) {
        return
            addContinuousCompoundInterestUsingRatePeriodMultiplication(
                value,
                interestRatePeriodMultiplication
            ) - value;
    }
    function calculateInterestPaidOut(
        uint256 calculateTimestamp,
        uint256 swapOpenTimestamp,
        uint256 swapNotional,
        uint256 swapFixedInterestRate
    ) internal pure returns (uint256) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            calculateTimestamp >= swapOpenTimestamp,
            AmmErrors.ds.CALC_TIMESTAMP_LOWER_THAN_SWAP_OPEN_TIMESTAMP
        );
        return
            swapNotional
                .calculateContinuousCompoundInterestUsingRatePeriodMultiplication(
                    swapFixedInterestRate *
                        (calculateTimestamp - swapOpenTimestamp)
                );
    }
    function rebalanceWhenCloseSwap(
        AmmStorageTypes.TestLib.SoapIndicators memory si,
        uint256 rebalanceTimestamp,
        uint256 swapOpenTimestamp,
        uint256 swapNotional,
        uint256 swapFixedInterestRate,
        uint256 swapIbtQuantity
    ) external pure returns (AmmStorageTypes.TestLib.SoapIndicators memory) {
        uint256 newAverageInterestRate = calculateAverageInterestRateWhenCloseSwap(
                si.totalNotional,
                si.averageInterestRate,
                swapNotional,
                swapFixedInterestRate
            );

        if (si.totalNotional != swapNotional) {
            uint256 currentHypoteticalInterestTotal = SoapIndicatorLogic
                .calculateHyphoteticalInterestTotal(si, rebalanceTimestamp);

            uint256 interestPaidOut = calculateInterestPaidOut(
                rebalanceTimestamp,
                swapOpenTimestamp,
                swapNotional,
                swapFixedInterestRate
            );

            if (currentHypoteticalInterestTotal >= interestPaidOut) {
                si.hypotheticalInterestCumulative =
                    currentHypoteticalInterestTotal -
                    interestPaidOut;
            } else {
                si.hypotheticalInterestCumulative = 0;
            }
            si.totalNotional = si.totalNotional - swapNotional;
            si.totalIbtQuantity = si.totalIbtQuantity - swapIbtQuantity;
            si.averageInterestRate = newAverageInterestRate;
            si.rebalanceTimestamp = rebalanceTimestamp;
        } else {
            /// @dev when newAverageInterestRate = 0 it means in IPOR Protocol is closing the LAST derivative on this leg.
            si.hypotheticalInterestCumulative = 0;
            si.totalNotional = 0;
            si.totalIbtQuantity = 0;
            si.averageInterestRate = 0;
            si.rebalanceTimestamp = rebalanceTimestamp;
        }

        return si;
    }
    function calculateAverageInterestRateWhenCloseSwap(
        uint256 totalNotional,
        uint256 averageInterestRate,
        uint256 swapNotional,
        uint256 swapFixedInterestRate
    ) internal pure returns (uint256 newAverageInterestRate) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(
            swapNotional <= totalNotional,
            AmmErrors.ds.SWAP_NOTIONAL_HIGHER_THAN_TOTAL_NOTIONAL
        );

        if (swapNotional == totalNotional) {
            return 0;
        } else {
            uint256 totalNotionalAndAverageInterestRate = totalNotional *
                averageInterestRate;
            uint256 swapNotionalAndSwapFixedInterestRate = swapNotional *
                swapFixedInterestRate;

            if (
                totalNotionalAndAverageInterestRate <=
                swapNotionalAndSwapFixedInterestRate
            ) {
                return 0;
            } else {
                newAverageInterestRate = IporMath.division(
                    (totalNotionalAndAverageInterestRate -
                        swapNotionalAndSwapFixedInterestRate),
                    (totalNotional - swapNotional)
                );
                if (averageInterestRate > 0) {
                    require(
                        newAverageInterestRate > 0,
                        AmmErrors
                            .ds
                            .AVERAGE_INTEREST_RATE_WHEN_CLOSE_SWAP_CANNOT_BE_ZERO
                    );
                }
            }
        }
    }
    function rebalanceWhenOpenSwap(
        AmmStorageTypes.TestLib.SoapIndicators memory si,
        uint256 rebalanceTimestamp,
        uint256 swapNotional,
        uint256 swapFixedInterestRate,
        uint256 swapIbtQuantity
    ) external pure returns (AmmStorageTypes.TestLib.SoapIndicators memory) {
        uint256 averageInterestRate = calculateAverageInterestRateWhenOpenSwap(
            si.totalNotional,
            si.averageInterestRate,
            swapNotional,
            swapFixedInterestRate
        );

        uint256 hypotheticalInterestTotal = SoapIndicatorLogic
            .calculateHyphoteticalInterestTotal(si, rebalanceTimestamp);

        si.rebalanceTimestamp = rebalanceTimestamp;
        si.totalNotional = si.totalNotional + swapNotional;
        si.totalIbtQuantity = si.totalIbtQuantity + swapIbtQuantity;
        si.averageInterestRate = averageInterestRate;
        si.hypotheticalInterestCumulative = hypotheticalInterestTotal;

        return si;
    }
    function calculateAverageInterestRateWhenOpenSwap(
        uint256 totalNotional,
        uint256 averageInterestRate,
        uint256 swapNotional,
        uint256 swapFixedInterestRate
    ) internal pure returns (uint256 newAverageInterestRate) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        newAverageInterestRate = IporMath.division(
            (totalNotional *
                averageInterestRate +
                swapNotional *
                swapFixedInterestRate),
            (totalNotional + swapNotional)
        );

        if (averageInterestRate != 0) {
            require(
                newAverageInterestRate > 0,
                AmmErrors.ds.AVERAGE_INTEREST_RATE_WHEN_OPEN_SWAP_CANNOT_BE_ZERO
            );
        }
    }
    function mul(bytes16 x, bytes16 y) internal pure returns (bytes16) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        unchecked {
            uint256 xExponent = (uint128(x) >> 112) & 0x7FFF;
            uint256 yExponent = (uint128(y) >> 112) & 0x7FFF;

            if (xExponent == 0x7FFF) {
                if (yExponent == 0x7FFF) {
                    if (x == y)
                        return x ^ (y & 0x80000000000000000000000000000000);
                    else if (x ^ y == 0x80000000000000000000000000000000)
                        return x | y;
                    else return ds.NaN;
                } else {
                    if (y & 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF == 0)
                        return ds.NaN;
                    else return x ^ (y & 0x80000000000000000000000000000000);
                }
            } else if (yExponent == 0x7FFF) {
                if (x & 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF == 0) return ds.NaN;
                else return y ^ (x & 0x80000000000000000000000000000000);
            } else {
                uint256 xSignifier = uint128(x) &
                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
                if (xExponent == 0) xExponent = 1;
                else xSignifier |= 0x10000000000000000000000000000;

                uint256 ySignifier = uint128(y) &
                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
                if (yExponent == 0) yExponent = 1;
                else ySignifier |= 0x10000000000000000000000000000;

                xSignifier *= ySignifier;
                if (xSignifier == 0)
                    return
                        (x ^ y) & 0x80000000000000000000000000000000 > 0
                            ? ds.NEGATIVE_ZERO
                            : ds.POSITIVE_ZERO;

                xExponent += yExponent;

                uint256 msb = xSignifier >=
                    0x200000000000000000000000000000000000000000000000000000000
                    ? 225
                    : xSignifier >=
                        0x100000000000000000000000000000000000000000000000000000000
                        ? 224
                        : mostSignificantBit(xSignifier);

                if (xExponent + msb < 16496) {
                    // Underflow
                    xExponent = 0;
                    xSignifier = 0;
                } else if (xExponent + msb < 16608) {
                    // Subnormal
                    if (xExponent < 16496) xSignifier >>= 16496 - xExponent;
                    else if (xExponent > 16496)
                        xSignifier <<= xExponent - 16496;
                    xExponent = 0;
                } else if (xExponent + msb > 49373) {
                    xExponent = 0x7FFF;
                    xSignifier = 0;
                } else {
                    if (msb > 112) xSignifier >>= msb - 112;
                    else if (msb < 112) xSignifier <<= 112 - msb;

                    xSignifier &= 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

                    xExponent = xExponent + msb - 16607;
                }

                return
                    bytes16(
                        uint128(
                            uint128(
                                (x ^ y) & 0x80000000000000000000000000000000
                            ) |
                                (xExponent << 112) |
                                xSignifier
                        )
                    );
            }
        }
    }
    function rayPow(uint256 x, uint256 n) internal pure returns (uint256 z) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        assembly {
            switch x
            case 0 {
                switch n
                case 0 {
                    z := ds.RAY
                }
                default {
                    z := 0
                }
            }
            default {
                switch mod(n, 2)
                case 0 {
                    z := ds.RAY
                }
                default {
                    z := x
                }
                let half := div(ds.RAY, 2) // for rounding.
                for {
                    n := div(n, 2)
                } n {
                    n := div(n, 2)
                } {
                    let xx := mul(x, x)
                    if iszero(eq(div(xx, x), x)) {
                        revert(0, 0)
                    }
                    let xxRound := add(xx, half)
                    if lt(xxRound, xx) {
                        revert(0, 0)
                    }
                    x := div(xxRound, ds.RAY)
                    if mod(n, 2) {
                        let zx := mul(z, x)
                        if and(iszero(iszero(x)), iszero(eq(div(zx, x), z))) {
                            revert(0, 0)
                        }
                        let zxRound := add(zx, half)
                        if lt(zxRound, zx) {
                            revert(0, 0)
                        }
                        z := div(zxRound, ds.RAY)
                    }
                }
            }
        }
    }
    function div(bytes16 x, bytes16 y) internal pure returns (bytes16) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        unchecked {
            uint256 xExponent = (uint128(x) >> 112) & 0x7FFF;
            uint256 yExponent = (uint128(y) >> 112) & 0x7FFF;

            if (xExponent == 0x7FFF) {
                if (yExponent == 0x7FFF) return ds.NaN;
                else return x ^ (y & 0x80000000000000000000000000000000);
            } else if (yExponent == 0x7FFF) {
                if (y & 0x0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF != 0) return ds.NaN;
                else
                    return
                        ds.POSITIVE_ZERO |
                        ((x ^ y) & 0x80000000000000000000000000000000);
            } else if (y & 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF == 0) {
                if (x & 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF == 0) return ds.NaN;
                else
                    return
                        ds.POSITIVE_INFINITY |
                        ((x ^ y) & 0x80000000000000000000000000000000);
            } else {
                uint256 ySignifier = uint128(y) &
                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
                if (yExponent == 0) yExponent = 1;
                else ySignifier |= 0x10000000000000000000000000000;

                uint256 xSignifier = uint128(x) &
                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
                if (xExponent == 0) {
                    if (xSignifier != 0) {
                        uint shift = 226 - mostSignificantBit(xSignifier);

                        xSignifier <<= shift;

                        xExponent = 1;
                        yExponent += shift - 114;
                    }
                } else {
                    xSignifier =
                        (xSignifier | 0x10000000000000000000000000000) <<
                        114;
                }

                xSignifier = xSignifier / ySignifier;
                if (xSignifier == 0)
                    return
                        (x ^ y) & 0x80000000000000000000000000000000 > 0
                            ? ds.NEGATIVE_ZERO
                            : ds.POSITIVE_ZERO;

                assert(xSignifier >= 0x1000000000000000000000000000);

                uint256 msb = xSignifier >= 0x80000000000000000000000000000
                    ? mostSignificantBit(xSignifier)
                    : xSignifier >= 0x40000000000000000000000000000
                        ? 114
                        : xSignifier >= 0x20000000000000000000000000000
                            ? 113
                            : 112;

                if (xExponent + msb > yExponent + 16497) {
                    // Overflow
                    xExponent = 0x7FFF;
                    xSignifier = 0;
                } else if (xExponent + msb + 16380 < yExponent) {
                    // Underflow
                    xExponent = 0;
                    xSignifier = 0;
                } else if (xExponent + msb + 16268 < yExponent) {
                    // Subnormal
                    if (xExponent + 16380 > yExponent)
                        xSignifier <<= xExponent + 16380 - yExponent;
                    else if (xExponent + 16380 < yExponent)
                        xSignifier >>= yExponent - xExponent - 16380;

                    xExponent = 0;
                } else {
                    // Normal
                    if (msb > 112) xSignifier >>= msb - 112;

                    xSignifier &= 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

                    xExponent = xExponent + msb + 16269 - yExponent;
                }

                return
                    bytes16(
                        uint128(
                            uint128(
                                (x ^ y) & 0x80000000000000000000000000000000
                            ) |
                                (xExponent << 112) |
                                xSignifier
                        )
                    );
            }
        }
    }
    function eq(bytes16 x, bytes16 y) internal pure returns (bool) {
        unchecked {
            if (x == y) {
                return
                    uint128(x) & 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF <
                    0x7FFF0000000000000000000000000000;
            } else return false;
        }
    }
    function add(bytes16 x, bytes16 y) internal pure returns (bytes16) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        unchecked {
            uint256 xExponent = (uint128(x) >> 112) & 0x7FFF;
            uint256 yExponent = (uint128(y) >> 112) & 0x7FFF;

            if (xExponent == 0x7FFF) {
                if (yExponent == 0x7FFF) {
                    if (x == y) return x;
                    else return ds.NaN;
                } else return x;
            } else if (yExponent == 0x7FFF) return y;
            else {
                bool xSign = uint128(x) >= 0x80000000000000000000000000000000;
                uint256 xSignifier = uint128(x) &
                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
                if (xExponent == 0) xExponent = 1;
                else xSignifier |= 0x10000000000000000000000000000;

                bool ySign = uint128(y) >= 0x80000000000000000000000000000000;
                uint256 ySignifier = uint128(y) &
                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
                if (yExponent == 0) yExponent = 1;
                else ySignifier |= 0x10000000000000000000000000000;

                if (xSignifier == 0)
                    return y == ds.NEGATIVE_ZERO ? ds.POSITIVE_ZERO : y;
                else if (ySignifier == 0)
                    return x == ds.NEGATIVE_ZERO ? ds.POSITIVE_ZERO : x;
                else {
                    int256 delta = int256(xExponent) - int256(yExponent);

                    if (xSign == ySign) {
                        if (delta > 112) return x;
                        else if (delta > 0) ySignifier >>= uint256(delta);
                        else if (delta < -112) return y;
                        else if (delta < 0) {
                            xSignifier >>= uint256(-delta);
                            xExponent = yExponent;
                        }

                        xSignifier += ySignifier;

                        if (xSignifier >= 0x20000000000000000000000000000) {
                            xSignifier >>= 1;
                            xExponent += 1;
                        }

                        if (xExponent == 0x7FFF)
                            return
                                xSign
                                    ? ds.NEGATIVE_INFINITY
                                    : ds.POSITIVE_INFINITY;
                        else {
                            if (xSignifier < 0x10000000000000000000000000000)
                                xExponent = 0;
                            else xSignifier &= 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

                            return
                                bytes16(
                                    uint128(
                                        (
                                            xSign
                                                ? 0x80000000000000000000000000000000
                                                : 0
                                        ) |
                                            (xExponent << 112) |
                                            xSignifier
                                    )
                                );
                        }
                    } else {
                        if (delta > 0) {
                            xSignifier <<= 1;
                            xExponent -= 1;
                        } else if (delta < 0) {
                            ySignifier <<= 1;
                            xExponent = yExponent - 1;
                        }

                        if (delta > 112) ySignifier = 1;
                        else if (delta > 1)
                            ySignifier =
                                ((ySignifier - 1) >> uint256(delta - 1)) +
                                1;
                        else if (delta < -112) xSignifier = 1;
                        else if (delta < -1)
                            xSignifier =
                                ((xSignifier - 1) >> uint256(-delta - 1)) +
                                1;

                        if (xSignifier >= ySignifier) xSignifier -= ySignifier;
                        else {
                            xSignifier = ySignifier - xSignifier;
                            xSign = ySign;
                        }

                        if (xSignifier == 0) return ds.POSITIVE_ZERO;

                        uint256 msb = mostSignificantBit(xSignifier);

                        if (msb == 113) {
                            xSignifier =
                                (xSignifier >> 1) &
                                0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
                            xExponent += 1;
                        } else if (msb < 112) {
                            uint256 shift = 112 - msb;
                            if (xExponent > shift) {
                                xSignifier =
                                    (xSignifier << shift) &
                                    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
                                xExponent -= shift;
                            } else {
                                xSignifier <<= xExponent - 1;
                                xExponent = 0;
                            }
                        } else xSignifier &= 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

                        if (xExponent == 0x7FFF)
                            return
                                xSign
                                    ? ds.NEGATIVE_INFINITY
                                    : ds.POSITIVE_INFINITY;
                        else
                            return
                                bytes16(
                                    uint128(
                                        (
                                            xSign
                                                ? 0x80000000000000000000000000000000
                                                : 0
                                        ) |
                                            (xExponent << 112) |
                                            xSignifier
                                    )
                                );
                    }
                }
            }
        }
    }
    function sub(bytes16 x, bytes16 y) internal pure returns (bytes16) {
        unchecked {
            return add(x, y ^ 0x80000000000000000000000000000000);
        }
    }
    function ln(bytes16 x) internal pure returns (bytes16) {
        unchecked {
            return mul(log_2(x), 0x3FFE62E42FEFA39EF35793C7673007E5);
        }
    }
    function log_2(bytes16 x) internal pure returns (bytes16) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        unchecked {
            if (uint128(x) > 0x80000000000000000000000000000000) return ds.NaN;
            else if (x == 0x3FFF0000000000000000000000000000)
                return ds.POSITIVE_ZERO;
            else {
                uint256 xExponent = (uint128(x) >> 112) & 0x7FFF;
                if (xExponent == 0x7FFF) return x;
                else {
                    uint256 xSignifier = uint128(x) &
                        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
                    if (xExponent == 0) xExponent = 1;
                    else xSignifier |= 0x10000000000000000000000000000;

                    if (xSignifier == 0) return ds.NEGATIVE_INFINITY;

                    bool resultNegative;
                    uint256 resultExponent = 16495;
                    uint256 resultSignifier;

                    if (xExponent >= 0x3FFF) {
                        resultNegative = false;
                        resultSignifier = xExponent - 0x3FFF;
                        xSignifier <<= 15;
                    } else {
                        resultNegative = true;
                        if (xSignifier >= 0x10000000000000000000000000000) {
                            resultSignifier = 0x3FFE - xExponent;
                            xSignifier <<= 15;
                        } else {
                            uint256 msb = mostSignificantBit(xSignifier);
                            resultSignifier = 16493 - msb;
                            xSignifier <<= 127 - msb;
                        }
                    }

                    if (xSignifier == 0x80000000000000000000000000000000) {
                        if (resultNegative) resultSignifier += 1;
                        uint256 shift = 112 -
                            mostSignificantBit(resultSignifier);
                        resultSignifier <<= shift;
                        resultExponent -= shift;
                    } else {
                        uint256 bb = resultNegative ? 1 : 0;
                        while (
                            resultSignifier < 0x10000000000000000000000000000
                        ) {
                            resultSignifier <<= 1;
                            resultExponent -= 1;

                            xSignifier *= xSignifier;
                            uint256 b = xSignifier >> 255;
                            resultSignifier += b ^ bb;
                            xSignifier >>= 127 + b;
                        }
                    }

                    return
                        bytes16(
                            uint128(
                                (
                                    resultNegative
                                        ? 0x80000000000000000000000000000000
                                        : 0
                                ) |
                                    (resultExponent << 112) |
                                    (resultSignifier &
                                        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
                            )
                        );
                }
            }
        }
    }
    function exp(bytes16 x) internal pure returns (bytes16) {
        unchecked {
            return pow_2(mul(x, 0x3FFF71547652B82FE1777D0FFDA0D23A));
        }
    }
    function pow_2(bytes16 x) internal pure returns (bytes16) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        unchecked {
            bool xNegative = uint128(x) > 0x80000000000000000000000000000000;
            uint256 xExponent = (uint128(x) >> 112) & 0x7FFF;
            uint256 xSignifier = uint128(x) & 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

            if (xExponent == 0x7FFF && xSignifier != 0) return ds.NaN;
            else if (xExponent > 16397)
                return xNegative ? ds.POSITIVE_ZERO : ds.POSITIVE_INFINITY;
            else if (xExponent < 16255)
                return 0x3FFF0000000000000000000000000000;
            else {
                if (xExponent == 0) xExponent = 1;
                else xSignifier |= 0x10000000000000000000000000000;

                if (xExponent > 16367) xSignifier <<= xExponent - 16367;
                else if (xExponent < 16367) xSignifier >>= 16367 - xExponent;

                if (
                    xNegative &&
                    xSignifier > 0x406E00000000000000000000000000000000
                ) return ds.POSITIVE_ZERO;

                if (
                    !xNegative &&
                    xSignifier > 0x3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                ) return ds.POSITIVE_INFINITY;

                uint256 resultExponent = xSignifier >> 128;
                xSignifier &= 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
                if (xNegative && xSignifier != 0) {
                    xSignifier = ~xSignifier;
                    resultExponent += 1;
                }

                uint256 resultSignifier = 0x80000000000000000000000000000000;
                if (xSignifier & 0x80000000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x16A09E667F3BCC908B2FB1366EA957D3E) >>
                        128;
                if (xSignifier & 0x40000000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1306FE0A31B7152DE8D5A46305C85EDEC) >>
                        128;
                if (xSignifier & 0x20000000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1172B83C7D517ADCDF7C8C50EB14A791F) >>
                        128;
                if (xSignifier & 0x10000000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10B5586CF9890F6298B92B71842A98363) >>
                        128;
                if (xSignifier & 0x8000000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1059B0D31585743AE7C548EB68CA417FD) >>
                        128;
                if (xSignifier & 0x4000000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x102C9A3E778060EE6F7CACA4F7A29BDE8) >>
                        128;
                if (xSignifier & 0x2000000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10163DA9FB33356D84A66AE336DCDFA3F) >>
                        128;
                if (xSignifier & 0x1000000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100B1AFA5ABCBED6129AB13EC11DC9543) >>
                        128;
                if (xSignifier & 0x800000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10058C86DA1C09EA1FF19D294CF2F679B) >>
                        128;
                if (xSignifier & 0x400000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1002C605E2E8CEC506D21BFC89A23A00F) >>
                        128;
                if (xSignifier & 0x200000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100162F3904051FA128BCA9C55C31E5DF) >>
                        128;
                if (xSignifier & 0x100000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000B175EFFDC76BA38E31671CA939725) >>
                        128;
                if (xSignifier & 0x80000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100058BA01FB9F96D6CACD4B180917C3D) >>
                        128;
                if (xSignifier & 0x40000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10002C5CC37DA9491D0985C348C68E7B3) >>
                        128;
                if (xSignifier & 0x20000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000162E525EE054754457D5995292026) >>
                        128;
                if (xSignifier & 0x10000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000B17255775C040618BF4A4ADE83FC) >>
                        128;
                if (xSignifier & 0x8000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000058B91B5BC9AE2EED81E9B7D4CFAB) >>
                        128;
                if (xSignifier & 0x4000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100002C5C89D5EC6CA4D7C8ACC017B7C9) >>
                        128;
                if (xSignifier & 0x2000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000162E43F4F831060E02D839A9D16D) >>
                        128;
                if (xSignifier & 0x1000000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000B1721BCFC99D9F890EA06911763) >>
                        128;
                if (xSignifier & 0x800000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000058B90CF1E6D97F9CA14DBCC1628) >>
                        128;
                if (xSignifier & 0x400000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000002C5C863B73F016468F6BAC5CA2B) >>
                        128;
                if (xSignifier & 0x200000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000162E430E5A18F6119E3C02282A5) >>
                        128;
                if (xSignifier & 0x100000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000B1721835514B86E6D96EFD1BFE) >>
                        128;
                if (xSignifier & 0x80000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000058B90C0B48C6BE5DF846C5B2EF) >>
                        128;
                if (xSignifier & 0x40000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000002C5C8601CC6B9E94213C72737A) >>
                        128;
                if (xSignifier & 0x20000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000162E42FFF037DF38AA2B219F06) >>
                        128;
                if (xSignifier & 0x10000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000B17217FBA9C739AA5819F44F9) >>
                        128;
                if (xSignifier & 0x8000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000058B90BFCDEE5ACD3C1CEDC823) >>
                        128;
                if (xSignifier & 0x4000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000002C5C85FE31F35A6A30DA1BE50) >>
                        128;
                if (xSignifier & 0x2000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000162E42FF0999CE3541B9FFFCF) >>
                        128;
                if (xSignifier & 0x1000000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000B17217F80F4EF5AADDA45554) >>
                        128;
                if (xSignifier & 0x800000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000058B90BFBF8479BD5A81B51AD) >>
                        128;
                if (xSignifier & 0x400000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000002C5C85FDF84BD62AE30A74CC) >>
                        128;
                if (xSignifier & 0x200000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000162E42FEFB2FED257559BDAA) >>
                        128;
                if (xSignifier & 0x100000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000B17217F7D5A7716BBA4A9AE) >>
                        128;
                if (xSignifier & 0x80000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000058B90BFBE9DDBAC5E109CCE) >>
                        128;
                if (xSignifier & 0x40000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000002C5C85FDF4B15DE6F17EB0D) >>
                        128;
                if (xSignifier & 0x20000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000162E42FEFA494F1478FDE05) >>
                        128;
                if (xSignifier & 0x10000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000B17217F7D20CF927C8E94C) >>
                        128;
                if (xSignifier & 0x8000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000058B90BFBE8F71CB4E4B33D) >>
                        128;
                if (xSignifier & 0x4000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000002C5C85FDF477B662B26945) >>
                        128;
                if (xSignifier & 0x2000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000162E42FEFA3AE53369388C) >>
                        128;
                if (xSignifier & 0x1000000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000B17217F7D1D351A389D40) >>
                        128;
                if (xSignifier & 0x800000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000058B90BFBE8E8B2D3D4EDE) >>
                        128;
                if (xSignifier & 0x400000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000002C5C85FDF4741BEA6E77E) >>
                        128;
                if (xSignifier & 0x200000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000162E42FEFA39FE95583C2) >>
                        128;
                if (xSignifier & 0x100000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000B17217F7D1CFB72B45E1) >>
                        128;
                if (xSignifier & 0x80000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000058B90BFBE8E7CC35C3F0) >>
                        128;
                if (xSignifier & 0x40000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000002C5C85FDF473E242EA38) >>
                        128;
                if (xSignifier & 0x20000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000162E42FEFA39F02B772C) >>
                        128;
                if (xSignifier & 0x10000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000B17217F7D1CF7D83C1A) >>
                        128;
                if (xSignifier & 0x8000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000058B90BFBE8E7BDCBE2E) >>
                        128;
                if (xSignifier & 0x4000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000002C5C85FDF473DEA871F) >>
                        128;
                if (xSignifier & 0x2000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000162E42FEFA39EF44D91) >>
                        128;
                if (xSignifier & 0x1000000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000B17217F7D1CF79E949) >>
                        128;
                if (xSignifier & 0x800000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000058B90BFBE8E7BCE544) >>
                        128;
                if (xSignifier & 0x400000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000002C5C85FDF473DE6ECA) >>
                        128;
                if (xSignifier & 0x200000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000162E42FEFA39EF366F) >>
                        128;
                if (xSignifier & 0x100000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000B17217F7D1CF79AFA) >>
                        128;
                if (xSignifier & 0x80000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000058B90BFBE8E7BCD6D) >>
                        128;
                if (xSignifier & 0x40000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000002C5C85FDF473DE6B2) >>
                        128;
                if (xSignifier & 0x20000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000162E42FEFA39EF358) >>
                        128;
                if (xSignifier & 0x10000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000B17217F7D1CF79AB) >>
                        128;
                if (xSignifier & 0x8000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000058B90BFBE8E7BCD5) >>
                        128;
                if (xSignifier & 0x4000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000002C5C85FDF473DE6A) >>
                        128;
                if (xSignifier & 0x2000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000162E42FEFA39EF34) >>
                        128;
                if (xSignifier & 0x1000000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000B17217F7D1CF799) >>
                        128;
                if (xSignifier & 0x800000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000058B90BFBE8E7BCC) >>
                        128;
                if (xSignifier & 0x400000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000002C5C85FDF473DE5) >>
                        128;
                if (xSignifier & 0x200000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000162E42FEFA39EF2) >>
                        128;
                if (xSignifier & 0x100000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000B17217F7D1CF78) >>
                        128;
                if (xSignifier & 0x80000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000058B90BFBE8E7BB) >>
                        128;
                if (xSignifier & 0x40000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000002C5C85FDF473DD) >>
                        128;
                if (xSignifier & 0x20000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000162E42FEFA39EE) >>
                        128;
                if (xSignifier & 0x10000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000B17217F7D1CF6) >>
                        128;
                if (xSignifier & 0x8000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000058B90BFBE8E7A) >>
                        128;
                if (xSignifier & 0x4000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000002C5C85FDF473C) >>
                        128;
                if (xSignifier & 0x2000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000162E42FEFA39D) >>
                        128;
                if (xSignifier & 0x1000000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000B17217F7D1CE) >>
                        128;
                if (xSignifier & 0x800000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000058B90BFBE8E6) >>
                        128;
                if (xSignifier & 0x400000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000002C5C85FDF472) >>
                        128;
                if (xSignifier & 0x200000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000162E42FEFA38) >>
                        128;
                if (xSignifier & 0x100000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000000B17217F7D1B) >>
                        128;
                if (xSignifier & 0x80000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000058B90BFBE8D) >>
                        128;
                if (xSignifier & 0x40000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000002C5C85FDF46) >>
                        128;
                if (xSignifier & 0x20000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000000162E42FEFA2) >>
                        128;
                if (xSignifier & 0x10000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000000B17217F7D0) >>
                        128;
                if (xSignifier & 0x8000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000000058B90BFBE7) >>
                        128;
                if (xSignifier & 0x4000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000002C5C85FDF3) >>
                        128;
                if (xSignifier & 0x2000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000000162E42FEF9) >>
                        128;
                if (xSignifier & 0x1000000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000000B17217F7C) >>
                        128;
                if (xSignifier & 0x800000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000000058B90BFBD) >>
                        128;
                if (xSignifier & 0x400000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000000002C5C85FDE) >>
                        128;
                if (xSignifier & 0x200000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000000162E42FEE) >>
                        128;
                if (xSignifier & 0x100000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000000000B17217F6) >>
                        128;
                if (xSignifier & 0x80000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000000058B90BFA) >>
                        128;
                if (xSignifier & 0x40000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000000002C5C85FC) >>
                        128;
                if (xSignifier & 0x20000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000000000162E42FD) >>
                        128;
                if (xSignifier & 0x10000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000000000B17217E) >>
                        128;
                if (xSignifier & 0x8000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000000000058B90BE) >>
                        128;
                if (xSignifier & 0x4000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000000002C5C85E) >>
                        128;
                if (xSignifier & 0x2000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000000000162E42E) >>
                        128;
                if (xSignifier & 0x1000000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000000000B17216) >>
                        128;
                if (xSignifier & 0x800000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000000000058B90A) >>
                        128;
                if (xSignifier & 0x400000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000000000002C5C84) >>
                        128;
                if (xSignifier & 0x200000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000000000162E41) >>
                        128;
                if (xSignifier & 0x100000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000000000000B1720) >>
                        128;
                if (xSignifier & 0x80000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000000000058B8F) >>
                        128;
                if (xSignifier & 0x40000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000000000002C5C7) >>
                        128;
                if (xSignifier & 0x20000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000000000000162E3) >>
                        128;
                if (xSignifier & 0x10000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000000000000B171) >>
                        128;
                if (xSignifier & 0x8000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000000000000058B8) >>
                        128;
                if (xSignifier & 0x4000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000000000002C5B) >>
                        128;
                if (xSignifier & 0x2000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000000000000162D) >>
                        128;
                if (xSignifier & 0x1000 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000000000000B16) >>
                        128;
                if (xSignifier & 0x800 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000000000000058A) >>
                        128;
                if (xSignifier & 0x400 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000000000000002C4) >>
                        128;
                if (xSignifier & 0x200 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000000000000161) >>
                        128;
                if (xSignifier & 0x100 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x1000000000000000000000000000000B0) >>
                        128;
                if (xSignifier & 0x80 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000000000000057) >>
                        128;
                if (xSignifier & 0x40 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000000000000002B) >>
                        128;
                if (xSignifier & 0x20 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000000000000015) >>
                        128;
                if (xSignifier & 0x10 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x10000000000000000000000000000000A) >>
                        128;
                if (xSignifier & 0x8 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000000000000004) >>
                        128;
                if (xSignifier & 0x4 > 0)
                    resultSignifier =
                        (resultSignifier *
                            0x100000000000000000000000000000001) >>
                        128;

                if (!xNegative) {
                    resultSignifier =
                        (resultSignifier >> 15) &
                        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
                    resultExponent += 0x3FFF;
                } else if (resultExponent <= 0x3FFE) {
                    resultSignifier =
                        (resultSignifier >> 15) &
                        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
                    resultExponent = 0x3FFF - resultExponent;
                } else {
                    resultSignifier =
                        resultSignifier >>
                        (resultExponent - 16367);
                    resultExponent = 0;
                }

                return
                    bytes16(uint128((resultExponent << 112) | resultSignifier));
            }
        }
    }
    function _toUint256(bytes16 value) private pure returns (uint256) {
        bytes16 decimals = ABDKMathQuad.fromUInt(1e18);
        bytes16 resultD18 = ABDKMathQuad.mul(value, decimals);
        return ABDKMathQuad.toUInt(resultD18);
    }
    function toUInt(bytes16 x) internal pure returns (uint256) {
        unchecked {
            uint256 exponent = (uint128(x) >> 112) & 0x7FFF;

            if (exponent < 16383) return 0; // Underflow

            require(uint128(x) < 0x80000000000000000000000000000000); // Negative

            require(exponent <= 16638); // Overflow
            uint256 result = (uint256(uint128(x)) &
                0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF) |
                0x10000000000000000000000000000;

            if (exponent < 16495) result >>= 16495 - exponent;
            else if (exponent > 16495) result <<= exponent - 16495;

            return result;
        }
    }
    function _toInt256(bytes16 value) private pure returns (int256) {
        bytes16 decimals = ABDKMathQuad.fromUInt(1e18);
        bytes16 resultD18 = ABDKMathQuad.mul(value, decimals);
        return ABDKMathQuad.toInt(resultD18);
    }
    function toInt(bytes16 x) internal pure returns (int256) {
        unchecked {
            uint256 exponent = (uint128(x) >> 112) & 0x7FFF;

            require(exponent <= 16638); // Overflow
            if (exponent < 16383) return 0; // Underflow

            uint256 result = (uint256(uint128(x)) &
                0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF) |
                0x10000000000000000000000000000;

            if (exponent < 16495) result >>= 16495 - exponent;
            else if (exponent > 16495) result <<= exponent - 16495;

            if (uint128(x) >= 0x80000000000000000000000000000000) {
                // Negative
                require(
                    result <=
                        0x8000000000000000000000000000000000000000000000000000000000000000
                );
                return -int256(result); // We rely on overflow behavior here
            } else {
                require(
                    result <=
                        0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                );
                return int256(result);
            }
        }
    }
    function calculateContinuousCompoundInterestUsingRatePeriodMultiplicationInt(
        int256 value,
        int256 interestRatePeriodMultiplication
    ) internal pure returns (int256) {
        return
            addContinuousCompoundInterestUsingRatePeriodMultiplicationInt(
                value,
                interestRatePeriodMultiplication
            ) - value;
    }
    function from128x128(int256 x) internal pure returns (bytes16) {
        unchecked {
            if (x == 0) return bytes16(0);
            else {
                // We rely on overflow behavior here
                uint256 result = uint256(x > 0 ? x : -x);

                uint256 msb = mostSignificantBit(result);
                if (msb < 112) result <<= 112 - msb;
                else if (msb > 112) result >>= msb - 112;

                result =
                    (result & 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF) |
                    ((16255 + msb) << 112);
                if (x < 0) result |= 0x80000000000000000000000000000000;

                return bytes16(uint128(result));
            }
        }
    }
    function from64x64(int128 x) internal pure returns (bytes16) {
        unchecked {
            if (x == 0) return bytes16(0);
            else {
                // We rely on overflow behavior here
                uint256 result = uint128(x > 0 ? x : -x);

                uint256 msb = mostSignificantBit(result);
                if (msb < 112) result <<= 112 - msb;
                else if (msb > 112) result >>= msb - 112;

                result =
                    (result & 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF) |
                    ((16319 + msb) << 112);
                if (x < 0) result |= 0x80000000000000000000000000000000;

                return bytes16(uint128(result));
            }
        }
    }
    function toOctuple(bytes16 x) internal pure returns (bytes32) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        unchecked {
            uint256 exponent = (uint128(x) >> 112) & 0x7FFF;

            uint256 result = uint128(x) & 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

            if (exponent == 0x7FFF)
                exponent = 0x7FFFF; // Infinity or ds.NaN
            else if (exponent == 0) {
                if (result > 0) {
                    uint256 msb = mostSignificantBit(result);
                    result =
                        (result << (236 - msb)) &
                        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
                    exponent = 245649 + msb;
                }
            } else {
                result <<= 124;
                exponent += 245760;
            }

            result |= exponent << 236;
            if (uint128(x) >= 0x80000000000000000000000000000000)
                result |= 0x8000000000000000000000000000000000000000000000000000000000000000;

            return bytes32(result);
        }
    }
    function fromDouble(bytes8 x) internal pure returns (bytes16) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        unchecked {
            uint256 exponent = (uint64(x) >> 52) & 0x7FF;

            uint256 result = uint64(x) & 0xFFFFFFFFFFFFF;

            if (exponent == 0x7FF)
                exponent = 0x7FFF; // Infinity or ds.NaN
            else if (exponent == 0) {
                if (result > 0) {
                    uint256 msb = mostSignificantBit(result);
                    result =
                        (result << (112 - msb)) &
                        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
                    exponent = 15309 + msb;
                }
            } else {
                result <<= 60;
                exponent += 15360;
            }

            result |= exponent << 112;
            if (x & 0x8000000000000000 > 0)
                result |= 0x80000000000000000000000000000000;

            return bytes16(uint128(result));
        }
    }
    function sqrt(bytes16 x) internal pure returns (bytes16) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        unchecked {
            if (uint128(x) > 0x80000000000000000000000000000000) return ds.NaN;
            else {
                uint256 xExponent = (uint128(x) >> 112) & 0x7FFF;
                if (xExponent == 0x7FFF) return x;
                else {
                    uint256 xSignifier = uint128(x) &
                        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
                    if (xExponent == 0) xExponent = 1;
                    else xSignifier |= 0x10000000000000000000000000000;

                    if (xSignifier == 0) return ds.POSITIVE_ZERO;

                    bool oddExponent = xExponent & 0x1 == 0;
                    xExponent = (xExponent + 16383) >> 1;

                    if (oddExponent) {
                        if (xSignifier >= 0x10000000000000000000000000000)
                            xSignifier <<= 113;
                        else {
                            uint256 msb = mostSignificantBit(xSignifier);
                            uint256 shift = (226 - msb) & 0xFE;
                            xSignifier <<= shift;
                            xExponent -= (shift - 112) >> 1;
                        }
                    } else {
                        if (xSignifier >= 0x10000000000000000000000000000)
                            xSignifier <<= 112;
                        else {
                            uint256 msb = mostSignificantBit(xSignifier);
                            uint256 shift = (225 - msb) & 0xFE;
                            xSignifier <<= shift;
                            xExponent -= (shift - 112) >> 1;
                        }
                    }

                    uint256 r = 0x10000000000000000000000000000;
                    r = (r + xSignifier / r) >> 1;
                    r = (r + xSignifier / r) >> 1;
                    r = (r + xSignifier / r) >> 1;
                    r = (r + xSignifier / r) >> 1;
                    r = (r + xSignifier / r) >> 1;
                    r = (r + xSignifier / r) >> 1;
                    r = (r + xSignifier / r) >> 1; // Seven iterations should be enough
                    uint256 r1 = xSignifier / r;
                    if (r1 < r) r = r1;

                    return
                        bytes16(
                            uint128(
                                (xExponent << 112) |
                                    (r & 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
                            )
                        );
                }
            }
        }
    }
}
