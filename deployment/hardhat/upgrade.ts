// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
// When running the script with `hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers, upgrades } from 'hardhat';
import { Contract, ContractFactory, BigNumber } from 'ethers';


// TODO: parse the deployed setget contract address for creating instance here
// const SetGetContract = require("../build/artifacts/contracts/SetGet.sol/SetGet.json")
// const ContractAAddress = 'storage-contract-address' || "";
const ContractAAddress = '0x3Aa5ebB10DC797CAC828524e59A333d0A371443c' || "";           // tested in localhost

// const ContractBAddress = 'contractB-address' || "";
const ContractBAddress = '0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9' || "";           // tested in localhost

async function main(): Promise<void> {
  // Hardhat always runs the compile task when running scripts through it.
  // If this runs in a standalone fashion you may want to call compile manually
  // to make sure everything is compiled
  // await run("compile");
    
  // ==============================================================================
  // We get the setget contract to upgrade
  const ContractAFactory: ContractFactory = await ethers.getContractFactory('ContractANew',);
  const contractA: Contract = await upgrades.upgradeProxy(ContractAAddress, ContractAFactory);
  console.log("ContractA upgraded to:", contractA.address);
  console.log(`The transaction that was sent to the network to deploy the upgraded contract A: ${
          contractA.deployTransaction.hash}`);

}




// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.  
main()
  .then(() => process.exit(0))
  .catch((error: Error) => {
    console.error(error);
    process.exit(1);
  });
