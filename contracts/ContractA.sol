// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import '@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol';
// import '@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import 'hardhat/console.sol';

/**
 * @title A "ContractA" contract
 */ 
contract ContractA is 
    Initializable, 
    OwnableUpgradeable, 
    PausableUpgradeable, 
    ReentrancyGuardUpgradeable 
{
    // using AddressUpgradeable for address;
    using SafeMathUpgradeable for uint256;

    // ==========State variables====================================
    uint256 private _value;

    // ==========Events=============================================
    event Set(address indexed doer, uint256 value);

    // ==========Constructor========================================
    function initialize() external virtual initializer {
        __Ownable_init();        // initialize the ownable contract with owner
    }

    // ==========Functions==========================================
    function set(uint256 _val) external onlyOwner whenNotPaused returns (bool) {
        _value = _value.add(_val);

        emit Set(_msgSender(), _val);

        return true;
    }

    function get() external view returns (uint256) {
        return _value;
    }

    // Reserved storage space to allow for layout changes in the future.
    uint256[50] private ______gap;

}