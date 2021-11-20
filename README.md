# Storage-contract
Storage contract for multiple tokens

## About
* [Instruction](./instruction.md)

## Transactions
```
// Part-A
SetGet contract deployed to:  0xa513E6E4b8f2a923D98304ec87F64353C4D5C853
The transaction that was sent to the network to deploy the contract: 0x444e1e4bce3d7b5509c8c3d6c8ad036639336ae6decc0a20249c4efb74af7d79

SetGet upgraded to: 0xa513E6E4b8f2a923D98304ec87F64353C4D5C853
The transaction that was sent to the network to deploy the upgraded contract: 0x547e9c1e95b4d7a153cc0590ac5412dd2fddcdafdb55403d06f67b8115b0f6b2
```
 
## Installation
```console
$ npm i
```

## Usage

### Build
```console
$ npx hardhat compile
```

### Test
```console
$ npx hardhat test
```

### Deploying contracts to localhost Hardhat EVM
#### localhost
```console
// on terminal-1
$ npx hardhat node

// on terminal-2
$ npx hardhat run deployment/hardhat/deploy.ts --network localhost
```


### Deploying contracts to Testnet (Public)
#### ETH Testnet - Rinkeby
* Environment variables
  - Create a `.env` file with its values:
```
INFURA_API_KEY=[YOUR_INFURA_API_KEY_HERE]
DEPLOYER_PRIVATE_KEY=[YOUR_DEPLOYER_PRIVATE_KEY_without_0x]
REPORT_GAS=<true_or_false>
```

* Deploy the contracts
```console
$ npx hardhat run deployment/testnet/rinkeby/deploy.ts  --network rinkeby
```

### Deploying contracts to Mainnet
#### ETH Mainnet
* Environment variables
  - Create a `.env` file with its values:
```
INFURA_API_KEY=[YOUR_INFURA_API_KEY_HERE]
DEPLOYER_PRIVATE_KEY=[YOUR_DEPLOYER_PRIVATE_KEY_without_0x]
REPORT_GAS=<true_or_false>
```

* Deploy the token on one-chain
```console
$ npx hardhat run deployment/mainnet/ETH/deploy.ts  --network mainnet
```
