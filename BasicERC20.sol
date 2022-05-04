// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "./accesscontrolled.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/draft-IERC20Permit.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract ERC20Token is ERC20Permit, AccessControlled {
    using SafeMath for uint256;
    
    

    constructor(address _authority)
        ERC20("BASIC", "BAS")
        ERC20Permit("BASIC")
        AccessControlled(BasicAuthority(_authority))
    {
        _mint(msg.sender,1000000000 *(10 **uint256(18)));
    }

    function mint(address account_, uint256 amount_) external onlyVault {
        _mint(account_, amount_);
    }

    function burn(uint256 amount) external  {
        _burn(msg.sender, amount);
    }

    function burnFrom(address account_, uint256 amount_) external  {
        _burnFrom(account_, amount_);
    }

    function _burnFrom(address account_, uint256 amount_) internal {
        uint256 decreasedAllowance_ = allowance(account_, msg.sender).sub(
            amount_,
            "ERC20: burn amount exceeds allowance"
        );

        _approve(account_, msg.sender, decreasedAllowance_);
        _burn(account_, amount_);
    }
}