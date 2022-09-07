const hre = require("hardhat");
const { WHITELIST_CONTRACT_ADDRESS, METADATA_URL } = require("../constants");

//This contract was deployed to this address 0xDbe08Eed54D2DFAFd470e1a438f2FBE9B0976EE9
async function main() {
  const whitelistContract = WHITELIST_CONTRACT_ADDRESS;
  const metadataURL = METADATA_URL;

  const contract = await hre.ethers.getContractFactory("sapanftpresale");
  const deployedContract = await contract.deploy(
    metadataURL,
    whitelistContract
  );
  await deployedContract.deployed();

  console.log("Please wait this contact is deploying...");

  console.log(
    `This contract was deployed deployed to ${deployedContract.address}`
  );
}
//
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
