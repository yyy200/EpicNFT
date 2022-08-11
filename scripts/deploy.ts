import { ethers } from "hardhat";

async function main() {
  // @ts-expect-error
  const nftContractFactory = await hre.ethers.getContractFactory("EpicNFT");
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("Contract deployed to:", nftContract.address);

  // Call the function.
  let txn = await nftContract.makeEpicNFT();
  // Wait for it to be mined.
  await txn.wait();
  console.log("Minted NFT #1", txn.hash);

  txn = await nftContract.makeEpicNFT();
  // Wait for it to be mined.
  await txn.wait();
  console.log("Minted NFT #2", txn.hash);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
