// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import '@openzeppelin/contracts/security/Pausable.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
// import '@openzeppelin/contracts/access/AccessControl.sol';
import '@openzeppelin/contracts/utils/Context.sol';
import '@openzeppelin/contracts/utils/Strings.sol';
// import '@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol';
// import '@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol';
// import '@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol';
// import '@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol';
// import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
// import '@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol';
import 'hardhat/console.sol';

/**
 * @title Contract B
 */
contract ContractB {
    // using AddressUpgradeable for address;
    // using SafeMathUpgradeable for uint256;

    // ==========State variables====================================

    address private _admin;
    mapping(bytes32 => mapping(address => bool) ) private _roles;
    bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;
    bool private initialized;

    // ==========Events=============================================
    event AdminAdded(address indexed account, uint256 currentTimestamp);
    event AdminRemoved(address indexed account, uint256 currentTimestamp);
    event AdminRoleTransferred(address indexed from, address indexed to, uint256 currentTimestamp);
    event AdminRoleRenounced(address indexed account, uint256 currentTimestamp);

    // ==========Constructor========================================
    // constructor() {
    //     _admin = msg.sender;
    //     _roles[DEFAULT_ADMIN_ROLE][msg.sender] = true;
    // }

    // function initialize() external initializer {
    //     _admin = msg.sender;
    //     _roles[DEFAULT_ADMIN_ROLE][msg.sender] = true;
    // }

    function setAdmin() internal {
        if(initialized) revert();

        _admin = msg.sender;
        _roles[DEFAULT_ADMIN_ROLE][msg.sender] = true;
        initialized = true;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyAdmin() {
        require(_admin == msg.sender, "ContractB: caller is not the owner");
        _;
    }


    // ==========Functions==========================================

    /**
     * @dev Returns the address of the current owner.
     */
    function getOwner() public view returns (address) {
        return _admin;
    }

    /**
     * @dev Returns `true` if `account` has been granted `role`.
     */
    function hasRole(bytes32 role, address account) public view returns (bool) {
        return _roles[role][account];
    }


    function addAdmin(address account) external onlyAdmin returns (bool) {
        if(!hasRole(DEFAULT_ADMIN_ROLE, account)) {
            _roles[DEFAULT_ADMIN_ROLE][account] = true;

            emit AdminAdded(account, block.timestamp);

            return true;
        }

        return false;

    }

    function removeAdmin(address account) external onlyAdmin returns (bool) {
        if(hasRole(DEFAULT_ADMIN_ROLE, account)) {
            _roles[DEFAULT_ADMIN_ROLE][account] = false;

            emit AdminRemoved(account, block.timestamp);

            return true;
        }

        return false;
    }

    function transferAdminRole(address from, address to) external onlyAdmin returns (bool) {
        if(!hasRole(DEFAULT_ADMIN_ROLE, to)) {
            _roles[DEFAULT_ADMIN_ROLE][from] = false; 
            _roles[DEFAULT_ADMIN_ROLE][to] = true;

            emit AdminRoleTransferred(from, to, block.timestamp);

            return true;
        }

        return false;
    }

    function renounceAdminRole() external onlyAdmin returns (bool) {
        _roles[DEFAULT_ADMIN_ROLE][msg.sender] = false;
        _roles[DEFAULT_ADMIN_ROLE][address(0)] = true;

        emit AdminRoleRenounced(msg.sender, block.timestamp);

        return true;
    }

    // Reserved storage space to allow for layout changes in the future.
    // uint256[46] private ______gap;

}





