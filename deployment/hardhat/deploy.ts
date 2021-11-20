// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
// When running the script with `hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers, upgrades } from 'hardhat';
import { Contract, ContractFactory, BigNumber } from 'ethers';
import { deployContract, solidity } from "ethereum-waffle";
import chai from "chai";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { config as dotenvConfig } from "dotenv";
import { resolve } from "path";
dotenvConfig({ path: resolve(__dirname, "./.env") });

chai.use(solidity);
const { expect } = chai;

async function main(): Promise<void> {
  // Hardhat always runs the compile task when running scripts through it.
  // If this runs in a standalone fashion you may want to call compile manually
  // to make sure everything is compiled
  // await run("compile");
  
  const [ownerA, ownerB, addr1, addr2] = await ethers.getSigners();

  // ==============================================================================
  // We get the contractA contract to deploy
  const ContractAFactory: ContractFactory = await ethers.getContractFactory('ContractA',);
  // deploy a upgradeable contract
  const contractA: Contract = await upgrades.deployProxy(ContractAFactory.connect(ownerA), []);
  await contractA.deployed();
  console.log('ContractA contract deployed to: ', contractA.address);

  console.log(
      `The transaction that was sent to the network to deploy the contract A: ${
          contractA.deployTransaction.hash
      }`
  );

  // ==============================================================================
  // We get the contractB contract to deploy
  const ContractBFactory: ContractFactory = await ethers.getContractFactory(
    'ContractB',
  );
  const contractB: Contract = await ContractBFactory.connect(ownerB).deploy();   // when non-upgradeable contract
  // const contractB: Contract = await upgrades.deployProxy(ContractBFactory.connect(ownerB), []);     // when upgradeable contract
  await contractB.deployed();
  console.log('ContractB contract deployed to: ', contractB.address);

  console.log(
      `The transaction that was sent to the network to deploy the contract B: ${
          contractB.deployTransaction.hash
      }`
  );


  // calling the getter function in contract A must return 0.
  expect(await contractA.get()).to.eq(0);

  const contractAOwnerAddress: String = await contractA.owner();

  // call the setter function with an input of 10.
  expect(await contractA/*.connect(contractAOwner)*/.set(10))
    .to.emit(contractA, 'Set');

  // Now call the getter function. It must return the value 10.
  expect(await contractA.get()).to.eq(10);

  // Fetch the admin address of contract A
  expect(contractAOwnerAddress).to.eq(ownerA.address);
  console.log(`ContractA Owner: ${contractAOwnerAddress}`);

  // Now, upgrade contract A so that it inherits contractB.
  // We get the contract A to upgrade
  const ContractANewFactory: ContractFactory = await ethers.getContractFactory('ContractANew',);
  const contractANew: Contract = await upgrades.upgradeProxy(contractA.address, ContractANewFactory/*.connect(ownerA)*/);
  console.log("ContractANew upgraded to:", contractANew.address);
  console.log(`The transaction that was sent to the network to deploy the upgraded contract A: ${
          contractANew.deployTransaction.hash}`);

  // Change the admin address of contract A to some other address from the access registry.
  const contractBOwnerAddress: String = await contractB.getOwner();
  expect(contractBOwnerAddress).to.eq(ownerB.address);
  console.log(`ContractB Owner: ${contractBOwnerAddress}`);

  // use some other address like `addr1` from top
  await contractANew.connect(ownerA).transferOwnership(addr1.address);
  // await contractB.connect(ownerB).addAdmin(addr1.address);

  // fetch the new contract owner
  expect(await contractANew.owner()).to.eq(addr1.address);

  // // Fetch the admin address of contract A. Should be different from the previous admin address.
  // // Function call 
  // // calling the getter function must return 10.
  expect(await contractANew.get()).to.eq(10);

  // // call the setter function with an input of 81
  expect(await contractANew.connect(addr1).set(81))
    .to.emit(contractANew, 'Set');

  // Now, call the getter function, it must return 91.
  expect(await contractANew.get()).to.eq(91);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.  
main()
  .then(() => process.exit(0))
  .catch((error: Error) => {
    console.error(error);
    process.exit(1);
  });
