[3 hours]
Problem statement
Objective: Solidity assessment
Tools: IDE, Solidity, web3/ hardhat

Part I
Create a contract A with a getter & a setter function.
Create a uint variable, which increases in value every time you call the setter function. The value increase is the same as the value provided in the setter function. While, when you call the getter function, it returns the value set in the uint variable.
Implement reentrancy guard & admin access for both the functions.
Deploy to binance smart chain testnet.
Deploy this contract through proxy upgradeability.


PART II
Create a contract B, that serves as an access registry. This contract serves as a ledger of the admin details(role, wallet address) of contract A.
ContractB  must have addAdmin, , removeAdmin, transferAdminRole, renounceAdminRole.
contractB also has its own admin address. Let us call it superAdmin.
You can use OpenZeppelin’s access.sol contract,  customise it to your needs.


Part III
Function call 
calling the getter function in contract A must return 0.
call the setter function with an input of 10.
Now call the getter function. It must return the value 10.
Fetch the admin address of contract A
Now, upgrade contract A so that it inherits contractB.
Change the admin address of contract A to some other address from the access registry.
Fetch the admin address of contract A. Should be different from the previous admin address.
Function call 
calling the getter function must return 10.
call the setter function with an input of 81
Now, call the getter function, it must return 91.

