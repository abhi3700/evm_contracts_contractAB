// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

// import '@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol';
// import '@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol';
// import '@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol';
// import '@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol';
// import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import './ContractB.sol';
import './ContractA.sol';
import 'hardhat/console.sol';

/**
 * @title A new ContractA contract
 */
contract ContractANew is 
	// Initializable, 
	// OwnableUpgradeable, 
	// PausableUpgradeable,
 //    ReentrancyGuardUpgradeable,
    ContractA,
    ContractB 
{
    // using AddressUpgradeable for address;
    // using SafeMathUpgradeable for uint256;

    // ==========State variables====================================
    // uint256 private _value;

    // ==========Events=============================================
    // event Set(address indexed doer, uint256 value);

    // ==========Constructor========================================
    function initialize(/*address adminOfContractB*/) external override initializer {
        // __Ownable_init();        // initialize the ownable contract with owner
        // initialize the contract B;
        ContractB.setAdmin(/*adminOfContractB*/);
    }

    // ==========Functions==========================================
    // function set(uint256 _val) external onlyOwner returns (bool) {
    //     _value = _value.add(_val);

    //     emit Set(msg.sender, _val);

    //     return true;
    // }

    // function get() external view returns (uint256) {
    //     return _value;
    // }

	// Reserved storage space to allow for layout changes in the future.
    uint256[50] private ______gap;
}