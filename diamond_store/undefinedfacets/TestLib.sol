library TestLib {
    bytes32 constant DIAMOND_STORAGE_POSITION =
        keccak256("diamond.standard.Test.storage");
    struct IporSwapId {
        /// @notice Swap's ID
        uint256 id;
        /// @notice Swap's direction, 0 - Pay Fixed Receive Floating, 1 - Receive Fixed Pay Floating
        uint8 direction;
    }
    struct ExtendedBalancesMemory {
        /// @notice Swap's balance for Pay Fixed leg
        uint256 totalCollateralPayFixed;
        /// @notice Swap's balance for Receive Fixed leg
        uint256 totalCollateralReceiveFixed;
        /// @notice Liquidity Pool's Balance
        uint256 liquidityPool;
        /// @notice AssetManagement's (Asset Management) balance
        uint256 vault;
        /// @notice IPOR publication fee balance. This balance is used to subsidise the oracle operations
        uint256 iporPublicationFee;
        /// @notice Balance of the DAO's treasury. Fed by portion of the opening fee set by the DAO
        uint256 treasury;
    }
    struct SoapIndicators {
        /// @notice Value of interest accrued on a fixed leg of all derivatives for this particular type of swap.
        /// @dev Represented in 18 decimals.
        uint256 hypotheticalInterestCumulative;
        /// @notice Sum of all swaps' notional amounts for a given leg.
        /// @dev Represented in 18 decimals.
        uint256 totalNotional;
        /// @notice Sum of all IBTs on a given leg.
        /// @dev Represented in 18 decimals.
        uint256 totalIbtQuantity;
        /// @notice The notional-weighted average interest rate of all swaps on a given leg combined.
        /// @dev Represented in 18 decimals.
        uint256 averageInterestRate;
        /// @notice EPOCH timestamp of when the most recent rebalancing took place
        uint256 rebalanceTimestamp;
    }
    struct TestStorage {
        uint256 MAX_VALUE;
        uint256 WAD_LEVERAGE_1000;
        uint256 YEAR_IN_SECONDS;
        uint256 MAX_CHUNK_SIZE;
        string LIQUIDITY_POOL_IS_EMPTY;
        string LIQUIDITY_POOL_AMOUNT_TOO_LOW;
        string LP_COLLATERAL_RATIO_EXCEEDED;
        string LP_COLLATERAL_RATIO_PER_LEG_EXCEEDED;
        string LIQUIDITY_POOL_BALANCE_IS_TOO_HIGH;
        string CANNOT_CLOSE_SWAP_LP_IS_TOO_LOW;
        string INCORRECT_SWAP_ID;
        string INCORRECT_SWAP_STATUS;
        string LEVERAGE_TOO_LOW;
        string LEVERAGE_TOO_HIGH;
        string TOTAL_AMOUNT_TOO_LOW;
        string TOTAL_AMOUNT_LOWER_THAN_FEE;
        string COLLATERAL_AMOUNT_TOO_HIGH;
        string ACCEPTABLE_FIXED_INTEREST_RATE_EXCEEDED;
        string SWAP_NOTIONAL_HIGHER_THAN_TOTAL_NOTIONAL;
        string MAX_LENGTH_LIQUIDATED_SWAPS_PER_LEG_EXCEEDED;
        string SOAP_AND_LP_BALANCE_SUM_IS_TOO_LOW;
        string CALC_TIMESTAMP_LOWER_THAN_SOAP_REBALANCE_TIMESTAMP;
        string CALC_TIMESTAMP_LOWER_THAN_SWAP_OPEN_TIMESTAMP;
        string CLOSING_TIMESTAMP_LOWER_THAN_SWAP_OPEN_TIMESTAMP;
        string CANNOT_CLOSE_SWAP_SENDER_IS_NOT_BUYER_NOR_LIQUIDATOR;
        string INTEREST_FROM_STRATEGY_EXCEEDED_THRESHOLD;
        string PUBLICATION_FEE_BALANCE_IS_TOO_LOW;
        string CALLER_NOT_TOKEN_MANAGER;
        string DEPOSIT_AMOUNT_IS_TOO_LOW;
        string VAULT_BALANCE_LOWER_THAN_DEPOSIT_VALUE;
        string TREASURY_BALANCE_IS_TOO_LOW;
        string CANNOT_CLOSE_SWAP_CLOSING_IS_TOO_EARLY;
        string CANNOT_CLOSE_SWAP_CLOSING_IS_TOO_EARLY_FOR_BUYER;
        string CANNOT_UNWIND_CLOSING_TOO_LATE;
        string UNSUPPORTED_SWAP_TENOR;
        string SENDER_NOT_AMM;
        string STORAGE_ID_IS_NOT_TIME_WEIGHTED_NOTIONAL;
        string FUNCTION_NOT_SUPPORTED;
        string UNSUPPORTED_DIRECTION;
        string INVALID_NOTIONAL;
        string AVERAGE_INTEREST_RATE_WHEN_OPEN_SWAP_CANNOT_BE_ZERO;
        string AVERAGE_INTEREST_RATE_WHEN_CLOSE_SWAP_CANNOT_BE_ZERO;
        string STETH_SUBMIT_FAILED;
        string COLLATERAL_IS_NOT_SUFFICIENT_TO_COVER_UNWIND_SWAP;
        string ASSET_MANAGEMENT_WITHDRAW_NOT_ENOUGH;
        string CANNOT_CLOSE_SWAP_WITH_UNWIND_ACTION_IS_TOO_EARLY;
        uint256 RAY;
        bytes16 POSITIVE_ZERO;
        bytes16 NEGATIVE_ZERO;
        bytes16 POSITIVE_INFINITY;
        bytes16 NEGATIVE_INFINITY;
        bytes16 NaN;
    }

    function diamondStorage() internal pure returns (TestStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
