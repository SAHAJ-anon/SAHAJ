// SPDX-License-Identifier: MIT
pragma solidity =0.8.10;










contract MainnetActionsUtilAddresses {
    address internal constant DFS_REG_CONTROLLER_ADDR = 0xF8f8B3C98Cf2E63Df3041b73f80F362a4cf3A576;
    address internal constant REGISTRY_ADDR = 0x287778F121F134C66212FB16c9b53eC991D32f5b;
    address internal constant DFS_LOGGER_ADDR = 0xcE7a977Cac4a481bc84AC06b2Da0df614e621cf3;
    address internal constant SUB_STORAGE_ADDR = 0x1612fc28Ee0AB882eC99842Cde0Fc77ff0691e90;
    address internal constant PROXY_AUTH_ADDR = 0x149667b6FAe2c63D1B4317C716b0D0e4d3E2bD70;
    address internal constant LSV_PROXY_REGISTRY_ADDRESS = 0xa8a3c86c4A2DcCf350E84D2b3c46BDeBc711C16e;
    address internal constant TRANSIENT_STORAGE = 0x2F7Ef2ea5E8c97B8687CA703A0e50Aa5a49B7eb2;
}







contract ActionsUtilHelper is MainnetActionsUtilAddresses {
}







contract MainnetAuthAddresses {
    address internal constant ADMIN_VAULT_ADDR = 0xCCf3d848e08b94478Ed8f46fFead3008faF581fD;
    address internal constant DSGUARD_FACTORY_ADDRESS = 0x5a15566417e6C1c9546523066500bDDBc53F88C7;
    address internal constant ADMIN_ADDR = 0x25eFA336886C74eA8E282ac466BdCd0199f85BB9; // USED IN ADMIN VAULT CONSTRUCTOR
    address internal constant PROXY_AUTH_ADDRESS = 0x149667b6FAe2c63D1B4317C716b0D0e4d3E2bD70;
    address internal constant MODULE_AUTH_ADDRESS = 0x7407974DDBF539e552F1d051e44573090912CC3D;
}







contract AuthHelper is MainnetAuthAddresses {
}








contract AdminVault is AuthHelper {
    address public owner;
    address public admin;

    error SenderNotAdmin();

    constructor() {
        owner = msg.sender;
        admin = ADMIN_ADDR;
    }

    /// @notice Admin is able to change owner
    /// @param _owner Address of new owner
    function changeOwner(address _owner) public {
        if (admin != msg.sender){
            revert SenderNotAdmin();
        }
        owner = _owner;
    }

    /// @notice Admin is able to set new admin
    /// @param _admin Address of multisig that becomes new admin
    function changeAdmin(address _admin) public {
        if (admin != msg.sender){
            revert SenderNotAdmin();
        }
        admin = _admin;
    }

}







interface IERC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint256 digits);
    function totalSupply() external view returns (uint256 supply);

    function balanceOf(address _owner) external view returns (uint256 balance);

    function transfer(address _to, uint256 _value) external returns (bool success);

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool success);

    function approve(address _spender, uint256 _value) external returns (bool success);

    function allowance(address _owner, address _spender) external view returns (uint256 remaining);

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}







library Address {
    //insufficient balance
    error InsufficientBalance(uint256 available, uint256 required);
    //unable to send value, recipient may have reverted
    error SendingValueFail();
    //insufficient balance for call
    error InsufficientBalanceForCall(uint256 available, uint256 required);
    //call to non-contract
    error NonContractCall();
    
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            codehash := extcodehash(account)
        }
        return (codehash != accountHash && codehash != 0x0);
    }

    function sendValue(address payable recipient, uint256 amount) internal {
        uint256 balance = address(this).balance;
        if (balance < amount){
            revert InsufficientBalance(balance, amount);
        }

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{value: amount}("");
        if (!(success)){
            revert SendingValueFail();
        }
    }

    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return
            functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        uint256 balance = address(this).balance;
        if (balance < value){
            revert InsufficientBalanceForCall(balance, value);
        }
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(
        address target,
        bytes memory data,
        uint256 weiValue,
        string memory errorMessage
    ) private returns (bytes memory) {
        if (!(isContract(target))){
            revert NonContractCall();
        }

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{value: weiValue}(data);
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}











library SafeERC20 {
    using Address for address;

    /**
     * @dev Transfer `value` amount of `token` from the calling contract to `to`. If `token` returns no value,
     * non-reverting calls are assumed to be successful.
     */
    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    /**
     * @dev Transfer `value` amount of `token` from `from` to `to`, spending the approval given by `from` to the
     * calling contract. If `token` returns no value, non-reverting calls are assumed to be successful.
     */
    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Set the calling contract's allowance toward `spender` to `value`. If `token` returns no value,
     * non-reverting calls are assumed to be successful. Compatible with tokens that require the approval to be set to
     * 0 before setting it to a non-zero value.
     */
    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        bytes memory approvalCall = abi.encodeWithSelector(token.approve.selector, spender, value);

        if (!_callOptionalReturnBool(token, approvalCall)) {
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, 0));
            _callOptionalReturn(token, approvalCall);
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address-functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        require(returndata.length == 0 || abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     *
     * This is a variant of {_callOptionalReturn} that silents catches all reverts and returns a bool instead.
     */
    function _callOptionalReturnBool(IERC20 token, bytes memory data) private returns (bool) {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We cannot use {Address-functionCall} here since this should return false
        // and not revert is the subcall reverts.

        (bool success, bytes memory returndata) = address(token).call(data);
        return success && (returndata.length == 0 || abi.decode(returndata, (bool))) && address(token).code.length > 0;
    }
}










contract AdminAuth is AuthHelper {
    using SafeERC20 for IERC20;

    AdminVault public constant adminVault = AdminVault(ADMIN_VAULT_ADDR);

    error SenderNotOwner();
    error SenderNotAdmin();

    modifier onlyOwner() {
        if (adminVault.owner() != msg.sender){
            revert SenderNotOwner();
        }
        _;
    }

    modifier onlyAdmin() {
        if (adminVault.admin() != msg.sender){
            revert SenderNotAdmin();
        }
        _;
    }

    /// @notice withdraw stuck funds
    function withdrawStuckFunds(address _token, address _receiver, uint256 _amount) public onlyOwner {
        if (_token == 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE) {
            payable(_receiver).transfer(_amount);
        } else {
            IERC20(_token).safeTransfer(_receiver, _amount);
        }
    }

    /// @notice Destroy the contract
    /// @dev Deprecated method, selfdestruct will soon just send eth
    function kill() public onlyAdmin {
        selfdestruct(payable(msg.sender));
    }
}








contract DFSRegistry is AdminAuth {
    error EntryAlreadyExistsError(bytes4);
    error EntryNonExistentError(bytes4);
    error EntryNotInChangeError(bytes4);
    error ChangeNotReadyError(uint256,uint256);
    error EmptyPrevAddrError(bytes4);
    error AlreadyInContractChangeError(bytes4);
    error AlreadyInWaitPeriodChangeError(bytes4);

    event AddNewContract(address,bytes4,address,uint256);
    event RevertToPreviousAddress(address,bytes4,address,address);
    event StartContractChange(address,bytes4,address,address);
    event ApproveContractChange(address,bytes4,address,address);
    event CancelContractChange(address,bytes4,address,address);
    event StartWaitPeriodChange(address,bytes4,uint256);
    event ApproveWaitPeriodChange(address,bytes4,uint256,uint256);
    event CancelWaitPeriodChange(address,bytes4,uint256,uint256);

    struct Entry {
        address contractAddr;
        uint256 waitPeriod;
        uint256 changeStartTime;
        bool inContractChange;
        bool inWaitPeriodChange;
        bool exists;
    }

    mapping(bytes4 => Entry) public entries;
    mapping(bytes4 => address) public previousAddresses;

    mapping(bytes4 => address) public pendingAddresses;
    mapping(bytes4 => uint256) public pendingWaitTimes;

    /// @notice Given an contract id returns the registered address
    /// @dev Id is keccak256 of the contract name
    /// @param _id Id of contract
    function getAddr(bytes4 _id) public view returns (address) {
        return entries[_id].contractAddr;
    }

    /// @notice Helper function to easily query if id is registered
    /// @param _id Id of contract
    function isRegistered(bytes4 _id) public view returns (bool) {
        return entries[_id].exists;
    }

    /////////////////////////// OWNER ONLY FUNCTIONS ///////////////////////////

    /// @notice Adds a new contract to the registry
    /// @param _id Id of contract
    /// @param _contractAddr Address of the contract
    /// @param _waitPeriod Amount of time to wait before a contract address can be changed
    function addNewContract(
        bytes4 _id,
        address _contractAddr,
        uint256 _waitPeriod
    ) public onlyOwner {
        if (entries[_id].exists){
            revert EntryAlreadyExistsError(_id);
        }

        entries[_id] = Entry({
            contractAddr: _contractAddr,
            waitPeriod: _waitPeriod,
            changeStartTime: 0,
            inContractChange: false,
            inWaitPeriodChange: false,
            exists: true
        });

        emit AddNewContract(msg.sender, _id, _contractAddr, _waitPeriod);
    }

    /// @notice Reverts to the previous address immediately
    /// @dev In case the new version has a fault, a quick way to fallback to the old contract
    /// @param _id Id of contract
    function revertToPreviousAddress(bytes4 _id) public onlyOwner {
        if (!(entries[_id].exists)){
            revert EntryNonExistentError(_id);
        }
        if (previousAddresses[_id] == address(0)){
            revert EmptyPrevAddrError(_id);
        }

        address currentAddr = entries[_id].contractAddr;
        entries[_id].contractAddr = previousAddresses[_id];

        emit RevertToPreviousAddress(msg.sender, _id, currentAddr, previousAddresses[_id]);
    }

    /// @notice Starts an address change for an existing entry
    /// @dev Can override a change that is currently in progress
    /// @param _id Id of contract
    /// @param _newContractAddr Address of the new contract
    function startContractChange(bytes4 _id, address _newContractAddr) public onlyOwner {
        if (!entries[_id].exists){
            revert EntryNonExistentError(_id);
        }
        if (entries[_id].inWaitPeriodChange){
            revert AlreadyInWaitPeriodChangeError(_id);
        }

        entries[_id].changeStartTime = block.timestamp; // solhint-disable-line
        entries[_id].inContractChange = true;

        pendingAddresses[_id] = _newContractAddr;

        emit StartContractChange(msg.sender, _id, entries[_id].contractAddr, _newContractAddr);
    }

    /// @notice Changes new contract address, correct time must have passed
    /// @param _id Id of contract
    function approveContractChange(bytes4 _id) public onlyOwner {
        if (!entries[_id].exists){
            revert EntryNonExistentError(_id);
        }
        if (!entries[_id].inContractChange){
            revert EntryNotInChangeError(_id);
        }
        if (block.timestamp < (entries[_id].changeStartTime + entries[_id].waitPeriod)){// solhint-disable-line
            revert ChangeNotReadyError(block.timestamp, (entries[_id].changeStartTime + entries[_id].waitPeriod));
        }

        address oldContractAddr = entries[_id].contractAddr;
        entries[_id].contractAddr = pendingAddresses[_id];
        entries[_id].inContractChange = false;
        entries[_id].changeStartTime = 0;

        pendingAddresses[_id] = address(0);
        previousAddresses[_id] = oldContractAddr;

        emit ApproveContractChange(msg.sender, _id, oldContractAddr, entries[_id].contractAddr);
    }

    /// @notice Cancel pending change
    /// @param _id Id of contract
    function cancelContractChange(bytes4 _id) public onlyOwner {
        if (!entries[_id].exists){
            revert EntryNonExistentError(_id);
        }
        if (!entries[_id].inContractChange){
            revert EntryNotInChangeError(_id);
        }

        address oldContractAddr = pendingAddresses[_id];

        pendingAddresses[_id] = address(0);
        entries[_id].inContractChange = false;
        entries[_id].changeStartTime = 0;

        emit CancelContractChange(msg.sender, _id, oldContractAddr, entries[_id].contractAddr);
    }

    /// @notice Starts the change for waitPeriod
    /// @param _id Id of contract
    /// @param _newWaitPeriod New wait time
    function startWaitPeriodChange(bytes4 _id, uint256 _newWaitPeriod) public onlyOwner {
        if (!entries[_id].exists){
            revert EntryNonExistentError(_id);
        }
        if (entries[_id].inContractChange){
            revert AlreadyInContractChangeError(_id);
        }

        pendingWaitTimes[_id] = _newWaitPeriod;

        entries[_id].changeStartTime = block.timestamp; // solhint-disable-line
        entries[_id].inWaitPeriodChange = true;

        emit StartWaitPeriodChange(msg.sender, _id, _newWaitPeriod);
    }

    /// @notice Changes new wait period, correct time must have passed
    /// @param _id Id of contract
    function approveWaitPeriodChange(bytes4 _id) public onlyOwner {
        if (!entries[_id].exists){
            revert EntryNonExistentError(_id);
        }
        if (!entries[_id].inWaitPeriodChange){
            revert EntryNotInChangeError(_id);
        }
        if (block.timestamp < (entries[_id].changeStartTime + entries[_id].waitPeriod)){ // solhint-disable-line
            revert ChangeNotReadyError(block.timestamp, (entries[_id].changeStartTime + entries[_id].waitPeriod));
        }

        uint256 oldWaitTime = entries[_id].waitPeriod;
        entries[_id].waitPeriod = pendingWaitTimes[_id];
        
        entries[_id].inWaitPeriodChange = false;
        entries[_id].changeStartTime = 0;

        pendingWaitTimes[_id] = 0;

        emit ApproveWaitPeriodChange(msg.sender, _id, oldWaitTime, entries[_id].waitPeriod);
    }

    /// @notice Cancel wait period change
    /// @param _id Id of contract
    function cancelWaitPeriodChange(bytes4 _id) public onlyOwner {
        if (!entries[_id].exists){
            revert EntryNonExistentError(_id);
        }
        if (!entries[_id].inWaitPeriodChange){
            revert EntryNotInChangeError(_id);
        }

        uint256 oldWaitPeriod = pendingWaitTimes[_id];

        pendingWaitTimes[_id] = 0;
        entries[_id].inWaitPeriodChange = false;
        entries[_id].changeStartTime = 0;

        emit CancelWaitPeriodChange(msg.sender, _id, oldWaitPeriod, entries[_id].waitPeriod);
    }
}







abstract contract DSAuthority {
    function canCall(
        address src,
        address dst,
        bytes4 sig
    ) public view virtual returns (bool);
}







contract DSAuthEvents {
    event LogSetAuthority(address indexed authority);
    event LogSetOwner(address indexed owner);
}

contract DSAuth is DSAuthEvents {
    DSAuthority public authority;
    address public owner;

    constructor() {
        owner = msg.sender;
        emit LogSetOwner(msg.sender);
    }

    function setOwner(address owner_) public auth {
        owner = owner_;
        emit LogSetOwner(owner);
    }

    function setAuthority(DSAuthority authority_) public auth {
        authority = authority_;
        emit LogSetAuthority(address(authority));
    }

    modifier auth {
        require(isAuthorized(msg.sender, msg.sig), "Not authorized");
        _;
    }

    function isAuthorized(address src, bytes4 sig) internal view returns (bool) {
        if (src == address(this)) {
            return true;
        } else if (src == owner) {
            return true;
        } else if (authority == DSAuthority(address(0))) {
            return false;
        } else {
            return authority.canCall(src, address(this), sig);
        }
    }
}







contract DSNote {
    event LogNote(
        bytes4 indexed sig,
        address indexed guy,
        bytes32 indexed foo,
        bytes32 indexed bar,
        uint256 wad,
        bytes fax
    ) anonymous;

    modifier note {
        bytes32 foo;
        bytes32 bar;

        assembly {
            foo := calldataload(4)
            bar := calldataload(36)
        }

        emit LogNote(msg.sig, msg.sender, foo, bar, msg.value, msg.data);

        _;
    }
}








abstract contract DSProxy is DSAuth, DSNote {
    DSProxyCache public cache; // global cache for contracts

    constructor(address _cacheAddr) {
        if (!(setCache(_cacheAddr))){
            require(isAuthorized(msg.sender, msg.sig), "Not authorized");
        }
    }

    // solhint-disable-next-line no-empty-blocks
    receive() external payable {}

    // use the proxy to execute calldata _data on contract _code
    function execute(bytes memory _code, bytes memory _data)
        public
        payable
        virtual
        returns (address target, bytes32 response);

    function execute(address _target, bytes memory _data)
        public
        payable
        virtual
        returns (bytes32 response);

    //set new cache
    function setCache(address _cacheAddr) public payable virtual returns (bool);
}

contract DSProxyCache {
    mapping(bytes32 => address) cache;

    function read(bytes memory _code) public view returns (address) {
        bytes32 hash = keccak256(_code);
        return cache[hash];
    }

    function write(bytes memory _code) public returns (address target) {
        assembly {
            target := create(0, add(_code, 0x20), mload(_code))
            switch iszero(extcodesize(target))
                case 1 {
                    // throw if contract failed to deploy
                    revert(0, 0)
                }
        }
        bytes32 hash = keccak256(_code);
        cache[hash] = target;
    }
}







interface ISafe {
    enum Operation {
        Call,
        DelegateCall
    }

    function setup(
        address[] calldata _owners,
        uint256 _threshold,
        address to,
        bytes calldata data,
        address fallbackHandler,
        address paymentToken,
        uint256 payment,
        address payable paymentReceiver
    ) external;

    function execTransaction(
        address to,
        uint256 value,
        bytes calldata data,
        Operation operation,
        uint256 safeTxGas,
        uint256 baseGas,
        uint256 gasPrice,
        address gasToken,
        address payable refundReceiver,
        bytes memory signatures
    ) external payable returns (bool success);

    function execTransactionFromModule(
        address to,
        uint256 value,
        bytes memory data,
        Operation operation
    ) external returns (bool success);

    function checkSignatures(
        bytes32 dataHash,
        bytes memory data,
        bytes memory signatures
    ) external view;

    function checkNSignatures(
        address executor,
        bytes32 dataHash,
        bytes memory /* data */,
        bytes memory signatures,
        uint256 requiredSignatures
    ) external view;

    function approveHash(bytes32 hashToApprove) external;

    function domainSeparator() external view returns (bytes32);

    function getTransactionHash(
        address to,
        uint256 value,
        bytes calldata data,
        Operation operation,
        uint256 safeTxGas,
        uint256 baseGas,
        uint256 gasPrice,
        address gasToken,
        address refundReceiver,
        uint256 _nonce
    ) external view returns (bytes32);

    function nonce() external view returns (uint256);

    function setFallbackHandler(address handler) external;

    function getOwners() external view returns (address[] memory);

    function isOwner(address owner) external view returns (bool);

    function getThreshold() external view returns (uint256);

    function enableModule(address module) external;

    function isModuleEnabled(address module) external view returns (bool);

    function disableModule(address prevModule, address module) external;

    function getModulesPaginated(
        address start,
        uint256 pageSize
    ) external view returns (address[] memory array, address next);
}







interface IDSProxyFactory {
    function isProxy(address _proxy) external view returns (bool);
}







contract MainnetProxyFactoryAddresses {
    address internal constant PROXY_FACTORY_ADDR = 0xA26e15C895EFc0616177B7c1e7270A4C7D51C997;
}







contract DSProxyFactoryHelper is MainnetProxyFactoryAddresses {
}









contract CheckWalletType is DSProxyFactoryHelper {
    function isDSProxy(address _proxy) public view returns (bool) {
        return IDSProxyFactory(PROXY_FACTORY_ADDR).isProxy(_proxy);
    }
}







contract DefisaverLogger {
    event RecipeEvent(
        address indexed caller,
        string indexed logName
    );

    event ActionDirectEvent(
        address indexed caller,
        string indexed logName,
        bytes data
    );

    function logRecipeEvent(
        string memory _logName
    ) public {
        emit RecipeEvent(msg.sender, _logName);
    }

    function logActionDirectEvent(
        string memory _logName,
        bytes memory _data
    ) public {
        emit ActionDirectEvent(msg.sender, _logName, _data);
    }
}













abstract contract ActionBase is AdminAuth, ActionsUtilHelper, CheckWalletType {
    event ActionEvent(
        string indexed logName,
        bytes data
    );

    DFSRegistry public constant registry = DFSRegistry(REGISTRY_ADDR);

    DefisaverLogger public constant logger = DefisaverLogger(
        DFS_LOGGER_ADDR
    );

    //Wrong sub index value
    error SubIndexValueError();
    //Wrong return index value
    error ReturnIndexValueError();

    /// @dev Subscription params index range [128, 255]
    uint8 public constant SUB_MIN_INDEX_VALUE = 128;
    uint8 public constant SUB_MAX_INDEX_VALUE = 255;

    /// @dev Return params index range [1, 127]
    uint8 public constant RETURN_MIN_INDEX_VALUE = 1;
    uint8 public constant RETURN_MAX_INDEX_VALUE = 127;

    /// @dev If the input value should not be replaced
    uint8 public constant NO_PARAM_MAPPING = 0;

    /// @dev We need to parse Flash loan actions in a different way
    enum ActionType { FL_ACTION, STANDARD_ACTION, FEE_ACTION, CHECK_ACTION, CUSTOM_ACTION }

    /// @notice Parses inputs and runs the implemented action through a user wallet
    /// @dev Is called by the RecipeExecutor chaining actions together
    /// @param _callData Array of input values each value encoded as bytes
    /// @param _subData Array of subscribed vales, replaces input values if specified
    /// @param _paramMapping Array that specifies how return and subscribed values are mapped in input
    /// @param _returnValues Returns values from actions before, which can be injected in inputs
    /// @return Returns a bytes32 value through user wallet, each actions implements what that value is
    function executeAction(
        bytes memory _callData,
        bytes32[] memory _subData,
        uint8[] memory _paramMapping,
        bytes32[] memory _returnValues
    ) public payable virtual returns (bytes32);

    /// @notice Parses inputs and runs the single implemented action through a user wallet
    /// @dev Used to save gas when executing a single action directly
    function executeActionDirect(bytes memory _callData) public virtual payable;

    /// @notice Returns the type of action we are implementing
    function actionType() public pure virtual returns (uint8);


    //////////////////////////// HELPER METHODS ////////////////////////////

    /// @notice Given an uint256 input, injects return/sub values if specified
    /// @param _param The original input value
    /// @param _mapType Indicated the type of the input in paramMapping
    /// @param _subData Array of subscription data we can replace the input value with
    /// @param _returnValues Array of subscription data we can replace the input value with
    function _parseParamUint(
        uint _param,
        uint8 _mapType,
        bytes32[] memory _subData,
        bytes32[] memory _returnValues
    ) internal pure returns (uint) {
        if (isReplaceable(_mapType)) {
            if (isReturnInjection(_mapType)) {
                _param = uint(_returnValues[getReturnIndex(_mapType)]);
            } else {
                _param = uint256(_subData[getSubIndex(_mapType)]);
            }
        }

        return _param;
    }


    /// @notice Given an addr input, injects return/sub values if specified
    /// @param _param The original input value
    /// @param _mapType Indicated the type of the input in paramMapping
    /// @param _subData Array of subscription data we can replace the input value with
    /// @param _returnValues Array of subscription data we can replace the input value with
    function _parseParamAddr(
        address _param,
        uint8 _mapType,
        bytes32[] memory _subData,
        bytes32[] memory _returnValues
    ) internal view returns (address) {
        if (isReplaceable(_mapType)) {
            if (isReturnInjection(_mapType)) {
                _param = address(bytes20((_returnValues[getReturnIndex(_mapType)])));
            } else {
                /// @dev The last two values are specially reserved for proxy addr and owner addr
                if (_mapType == 254) return address(this); // wallet address
                if (_mapType == 255) return fetchOwnersOrWallet(); // owner if 1/1 wallet or the wallet itself

                _param = address(uint160(uint256(_subData[getSubIndex(_mapType)])));
            }
        }

        return _param;
    }

    /// @notice Given an bytes32 input, injects return/sub values if specified
    /// @param _param The original input value
    /// @param _mapType Indicated the type of the input in paramMapping
    /// @param _subData Array of subscription data we can replace the input value with
    /// @param _returnValues Array of subscription data we can replace the input value with
    function _parseParamABytes32(
        bytes32 _param,
        uint8 _mapType,
        bytes32[] memory _subData,
        bytes32[] memory _returnValues
    ) internal pure returns (bytes32) {
        if (isReplaceable(_mapType)) {
            if (isReturnInjection(_mapType)) {
                _param = (_returnValues[getReturnIndex(_mapType)]);
            } else {
                _param = _subData[getSubIndex(_mapType)];
            }
        }

        return _param;
    }

    /// @notice Checks if the paramMapping value indicated that we need to inject values
    /// @param _type Indicated the type of the input
    function isReplaceable(uint8 _type) internal pure returns (bool) {
        return _type != NO_PARAM_MAPPING;
    }

    /// @notice Checks if the paramMapping value is in the return value range
    /// @param _type Indicated the type of the input
    function isReturnInjection(uint8 _type) internal pure returns (bool) {
        return (_type >= RETURN_MIN_INDEX_VALUE) && (_type <= RETURN_MAX_INDEX_VALUE);
    }

    /// @notice Transforms the paramMapping value to the index in return array value
    /// @param _type Indicated the type of the input
    function getReturnIndex(uint8 _type) internal pure returns (uint8) {
        if (!(isReturnInjection(_type))){
            revert SubIndexValueError();
        }

        return (_type - RETURN_MIN_INDEX_VALUE);
    }

    /// @notice Transforms the paramMapping value to the index in sub array value
    /// @param _type Indicated the type of the input
    function getSubIndex(uint8 _type) internal pure returns (uint8) {
        if (_type < SUB_MIN_INDEX_VALUE){
            revert ReturnIndexValueError();
        }
        return (_type - SUB_MIN_INDEX_VALUE);
    }

    function fetchOwnersOrWallet() internal view returns (address) {
        if (isDSProxy(address(this))) 
            return DSProxy(payable(address(this))).owner();

        // if not DSProxy, we assume we are in context of Safe
        address[] memory owners = ISafe(address(this)).getOwners();
        return owners.length == 1 ? owners[0] : address(this);
    }
}







contract MainnetFLAddresses {
    address internal constant SOLO_MARGIN_ADDRESS = 0x1E0447b19BB6EcFdAe1e4AE1694b0C3659614e4e;
    address internal constant ETH_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    address internal constant WETH_ADDRESS = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address internal constant DYDX_FL_FEE_FAUCET = 0x47f159C90850D5cE09E21F931d504536840f34b4;

    address internal constant AAVE_LENDING_POOL = 0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9;
    address internal constant AAVE_LENDING_POOL_ADDRESS_PROVIDER = 0xB53C1a33016B2DC2fF3653530bfF1848a515c8c5;

    address internal constant AAVE_V3_LENDING_POOL = 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2;
    address internal constant AAVE_V3_LENDING_POOL_ADDRESS_PROVIDER = 0x2f39d218133AFaB8F2B819B1066c7E434Ad94E9e;

    address internal constant SPARK_LENDING_POOL_ADDRESS_PROVIDER = 0x02C3eA4e34C0cBd694D2adFa2c690EECbC1793eE;
    address internal constant SPARK_LENDING_POOL = 0xC13e21B648A5Ee794902342038FF3aDAB66BE987;

    address internal constant DSS_FLASH_ADDR = 0x60744434d6339a6B27d73d9Eda62b6F66a0a04FA;
    address internal constant DAI_ADDR = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address internal constant ST_ETH_ADDR = 0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84;
    address internal constant VAULT_ADDR = 0xBA12222222228d8Ba445958a75a0704d566BF2C8;

    address internal constant GHO_ADDR = 0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f;
    address internal constant GHO_FLASH_MINTER_ADDR = 0xb639D208Bcf0589D54FaC24E655C79EC529762B8;
    address internal constant UNI_V3_FACTORY = 0x1F98431c8aD98523631AE4a59f267346ea31F984;

    address internal constant MORPHO_BLUE_ADDR = 0xBBBBBbbBBb9cC5e90e3b3Af64bdAF62C37EEFFCb;

    address internal constant RECIPE_EXECUTOR_ADDR = 0x5029336642814bC51a42bA80BF83a6322110035D;
}









contract StrategyModel {
        
    /// @dev Group of strategies bundled together so user can sub to multiple strategies at once
    /// @param creator Address of the user who created the bundle
    /// @param strategyIds Array of strategy ids stored in StrategyStorage
    struct StrategyBundle {
        address creator;
        uint64[] strategyIds;
    }

    /// @dev Template/Class which defines a Strategy
    /// @param name Name of the strategy useful for logging what strategy is executing
    /// @param creator Address of the user which created the strategy
    /// @param triggerIds Array of identifiers for trigger - bytes4(keccak256(TriggerName))
    /// @param actionIds Array of identifiers for actions - bytes4(keccak256(ActionName))
    /// @param paramMapping Describes how inputs to functions are piped from return/subbed values
    /// @param continuous If the action is repeated (continuos) or one time
    struct Strategy {
        string name;
        address creator;
        bytes4[] triggerIds;
        bytes4[] actionIds;
        uint8[][] paramMapping;
        bool continuous;
    }

    /// @dev List of actions grouped as a recipe
    /// @param name Name of the recipe useful for logging what recipe is executing
    /// @param callData Array of calldata inputs to each action
    /// @param subData Used only as part of strategy, subData injected from StrategySub.subData
    /// @param actionIds Array of identifiers for actions - bytes4(keccak256(ActionName))
    /// @param paramMapping Describes how inputs to functions are piped from return/subbed values
    struct Recipe {
        string name;
        bytes[] callData;
        bytes32[] subData;
        bytes4[] actionIds;
        uint8[][] paramMapping;
    }

    /// @dev Actual data of the sub we store on-chain
    /// @dev In order to save on gas we store a keccak256(StrategySub) and verify later on
    /// @param walletAddr Address of the users smart wallet/proxy
    /// @param isEnabled Toggle if the subscription is active
    /// @param strategySubHash Hash of the StrategySub data the user inputted
    struct StoredSubData {
        bytes20 walletAddr; // address but put in bytes20 for gas savings
        bool isEnabled;
        bytes32 strategySubHash;
    }

    /// @dev Instance of a strategy, user supplied data
    /// @param strategyOrBundleId Id of the strategy or bundle, depending on the isBundle bool
    /// @param isBundle If true the id points to bundle, if false points directly to strategyId
    /// @param triggerData User supplied data needed for checking trigger conditions
    /// @param subData User supplied data used in recipe
    struct StrategySub {
        uint64 strategyOrBundleId;
        bool isBundle;
        bytes[] triggerData;
        bytes32[] subData;
    }
}







abstract contract IDSProxy {
    // function execute(bytes memory _code, bytes memory _data)
    //     public
    //     payable
    //     virtual
    //     returns (address, bytes32);

    function execute(address _target, bytes memory _data) public payable virtual returns (bytes32);

    function setCache(address _cacheAddr) public payable virtual returns (bool);

    function owner() public view virtual returns (address);
}









contract FLFeeFaucet {

    using SafeERC20 for IERC20;

    /// @notice Sends 2 wei to msg.sender
    /// @dev Anyone can call this method but it's not economically feasible to drain
    /// @param _tokenAddr Address of the token we want 2 wei
    function my2Wei(address _tokenAddr) public {
        IERC20(_tokenAddr).safeTransfer(msg.sender, 2);
    }
}











contract FLHelper is MainnetFLAddresses, StrategyModel {
    uint16 internal constant AAVE_REFERRAL_CODE = 64;
    uint16 internal constant SPARK_REFERRAL_CODE = 0;

    FLFeeFaucet public constant flFeeFaucet = FLFeeFaucet(DYDX_FL_FEE_FAUCET);

    /// @dev Function sig of RecipeExecutor._executeActionsFromFL()
    bytes4 public constant CALLBACK_SELECTOR =
        bytes4(
            keccak256(
                "_executeActionsFromFL((string,bytes[],bytes32[],bytes4[],uint8[][]),bytes32)"
            )
        );

    // Revert if execution fails when using safe wallet
    error SafeExecutionError();

    function _executeRecipe(address _wallet, bool _isDSProxy, Recipe memory _currRecipe, uint256 _paybackAmount) internal {
        if (_isDSProxy) {
            IDSProxy(_wallet).execute{value: address(this).balance}(
                RECIPE_EXECUTOR_ADDR,
                abi.encodeWithSelector(CALLBACK_SELECTOR, _currRecipe, _paybackAmount)
            );
        } else {
            bool success = ISafe(_wallet).execTransactionFromModule(
                RECIPE_EXECUTOR_ADDR,
                address(this).balance,
                abi.encodeWithSelector(CALLBACK_SELECTOR, _currRecipe, _paybackAmount),
                ISafe.Operation.DelegateCall
            );

            if (!success) {
                revert SafeExecutionError();
             }
        }
    }
}






interface IERC3156FlashBorrower {
    /**
     * @dev Receive a flash loan.
     * @param initiator The initiator of the loan.
     * @param token The loan currency.
     * @param amount The amount of tokens lent.
     * @param fee The additional amount of tokens to repay.
     * @param data Arbitrary data structure, intended to contain user-defined parameters.
     * @return The keccak256 hash of "ERC3156FlashBorrower.onFlashLoan"
     */
    function onFlashLoan(
        address initiator,
        address token,
        uint256 amount,
        uint256 fee,
        bytes calldata data
    ) external returns (bytes32);
}






interface IERC3156FlashLender {
    /**
     * @dev The amount of currency available to be lent.
     * @param token The loan currency.
     * @return The amount of `token` that can be borrowed.
     */
    function maxFlashLoan(
        address token
    ) external view returns (uint256);

    /**
     * @dev The fee to be charged for a given loan.
     * @param token The loan currency.
     * @param amount The amount of tokens lent.
     * @return The amount of `token` to be charged for the loan, on top of the returned principal.
     */
    function flashFee(
        address token,
        uint256 amount
    ) external view returns (uint256);

    /**
     * @dev Initiate a flash loan.
     * @param receiver The receiver of the tokens in the loan, and the receiver of the callback.
     * @param token The loan currency.
     * @param amount The amount of tokens lent.
     * @param data Arbitrary data structure, intended to contain user-defined parameters.
     */
    function flashLoan(
        IERC3156FlashBorrower receiver,
        address token,
        uint256 amount,
        bytes calldata data
    ) external returns (bool);
}






abstract contract IFlashLoanBase{
    
    struct FlashLoanParams {
        address[] tokens;
        uint256[] amounts;
        uint256[] modes;
        address onBehalfOf;
        address flParamGetterAddr;
        bytes flParamGetterData;
        bytes recipeData;
    }
}







abstract contract IFLParamGetter {
    function getFlashLoanParams(bytes memory _data)
        public
        view
        virtual
        returns (
            address[] memory tokens,
            uint256[] memory amount,
            uint256[] memory modes
        );
}







abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;
    
    error ReentrantCall();

    constructor () {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and make it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        if (_status == _ENTERED){
            revert ReentrantCall();
        }

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
}







abstract contract IWETH {
    function allowance(address, address) public virtual view returns (uint256);

    function balanceOf(address) public virtual view returns (uint256);

    function approve(address, uint256) public virtual;

    function transfer(address, uint256) public virtual returns (bool);

    function transferFrom(
        address,
        address,
        uint256
    ) public virtual returns (bool);

    function deposit() public payable virtual;

    function withdraw(uint256) public virtual;
}








library TokenUtils {
    using SafeERC20 for IERC20;

    address public constant WETH_ADDR = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address public constant ETH_ADDR = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    /// @dev Only approves the amount if allowance is lower than amount, does not decrease allowance
    function approveToken(
        address _tokenAddr,
        address _to,
        uint256 _amount
    ) internal {
        if (_tokenAddr == ETH_ADDR) return;

        if (IERC20(_tokenAddr).allowance(address(this), _to) < _amount) {
            IERC20(_tokenAddr).safeApprove(_to, _amount);
        }
    }

    function pullTokensIfNeeded(
        address _token,
        address _from,
        uint256 _amount
    ) internal returns (uint256) {
        // handle max uint amount
        if (_amount == type(uint256).max) {
            _amount = getBalance(_token, _from);
        }

        if (_from != address(0) && _from != address(this) && _token != ETH_ADDR && _amount != 0) {
            IERC20(_token).safeTransferFrom(_from, address(this), _amount);
        }

        return _amount;
    }

    function withdrawTokens(
        address _token,
        address _to,
        uint256 _amount
    ) internal returns (uint256) {
        if (_amount == type(uint256).max) {
            _amount = getBalance(_token, address(this));
        }

        if (_to != address(0) && _to != address(this) && _amount != 0) {
            if (_token != ETH_ADDR) {
                IERC20(_token).safeTransfer(_to, _amount);
            } else {
                (bool success, ) = _to.call{value: _amount}("");
                require(success, "Eth send fail");
            }
        }

        return _amount;
    }

    function depositWeth(uint256 _amount) internal {
        IWETH(WETH_ADDR).deposit{value: _amount}();
    }

    function withdrawWeth(uint256 _amount) internal {
        IWETH(WETH_ADDR).withdraw(_amount);
    }

    function getBalance(address _tokenAddr, address _acc) internal view returns (uint256) {
        if (_tokenAddr == ETH_ADDR) {
            return _acc.balance;
        } else {
            return IERC20(_tokenAddr).balanceOf(_acc);
        }
    }

    function getTokenDecimals(address _token) internal view returns (uint256) {
        if (_token == ETH_ADDR) return 18;

        return IERC20(_token).decimals();
    }
}












contract FLMaker is ActionBase, ReentrancyGuard, IERC3156FlashBorrower, IFlashLoanBase, FLHelper {
    using TokenUtils for address;

    bytes32 public constant CALLBACK_SUCCESS = keccak256("ERC3156FlashBorrower.onFlashLoan");

    function executeAction(
        bytes memory _callData,
        bytes32[] memory,
        uint8[] memory,
        bytes32[] memory
    ) public override payable returns (bytes32) {
        FlashLoanParams memory params = parseInputs(_callData);

        if (params.flParamGetterAddr != address(0)) {
            (, uint256[] memory amounts,) =
                IFLParamGetter(params.flParamGetterAddr).getFlashLoanParams(params.flParamGetterData);

            params.amounts[0] = amounts[0];
        }
        bytes memory recipeData = params.recipeData;
        uint256 amount = _flMaker(params.amounts[0], recipeData);
        return bytes32(amount);
    }

    // solhint-disable-next-line no-empty-blocks
    function executeActionDirect(bytes memory _callData) public override payable {}

    /// @inheritdoc ActionBase
    function actionType() public override pure returns (uint8) {
        return uint8(ActionType.FL_ACTION);
    }

    /// @notice Gets a DAI flash loan from Maker and returns back the execution to the action address
    /// @param _amount Amount of DAI to FL
    /// @param _taskData Rest of the data we have in the task
    function _flMaker(uint256 _amount, bytes memory _taskData) internal returns (uint256) {
        IERC3156FlashLender(DSS_FLASH_ADDR).flashLoan(
            IERC3156FlashBorrower(address(this)),
            DAI_ADDR,
            _amount,
            _taskData
        );

        emit ActionEvent("FLMaker", abi.encode(_amount));
        return _amount;
    }

    /// @notice ERC3156 callback function that formats and calls back RecipeExecutor
    function onFlashLoan(
        address _initiator,
        address _token,
        uint256 _amount,
        uint256 _fee,
        bytes calldata _data
    ) external override nonReentrant returns (bytes32) {
        require(msg.sender == address(DSS_FLASH_ADDR), "Untrusted lender");
        require(_initiator == address(this), "Untrusted loan initiator");

        (Recipe memory currRecipe, address wallet) = abi.decode(_data, (Recipe, address));
        _token.withdrawTokens(wallet, _amount);
        uint256 balanceBefore = _token.getBalance(address(this));

        uint256 paybackAmount = _amount + _fee;

        _executeRecipe(wallet, isDSProxy(wallet), currRecipe, paybackAmount);

        require(_token.getBalance(address(this)) == paybackAmount + balanceBefore, "Wrong payback amount");

        _token.approveToken(DSS_FLASH_ADDR, paybackAmount);
        return CALLBACK_SUCCESS;
    }

    function parseInputs(bytes memory _callData)
        public
        pure
        returns (FlashLoanParams memory params)
    {
        params = abi.decode(_callData, (FlashLoanParams));
    }
}
