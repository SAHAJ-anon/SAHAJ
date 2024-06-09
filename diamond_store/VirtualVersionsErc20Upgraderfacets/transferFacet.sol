// SPDX-License-Identifier: MIT

pragma solidity =0.8.9;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

import "./TestLib.sol";
contract transferFacet {
    function transfer(address to, uint256 amount) external returns (bool);
    function withdraw(
        address _token,
        address _recipient,
        uint256 _amount
    ) external onlyAdmin {
        require(
            IERC20(_token).transfer(_recipient, _amount),
            "TA-6: transfer failed"
        );
    }
    function upgrade(address _recipient, uint256 _amount) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        require(_amount != 0, "TA-2: zero token amount");
        require(_recipient != address(0), "TA-3: zero recipient address");

        require(
            IERC20(ds.oldToken_).transferFrom(
                msg.sender,
                ds.BLACK_HOLE_ADDRESS,
                _amount
            ),
            "TA-7: burn failed"
        );
        require(
            IERC20(ds.newToken_).transfer(_recipient, _amount),
            "TA-8: transfer failed"
        );
    }
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}
