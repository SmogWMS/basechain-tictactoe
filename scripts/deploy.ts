import { ethers } from "hardhat";

async function main() {
  const TicTacToe = await ethers.getContractFactory("TicTacToe");
  const tic = await TicTacToe.deploy();
  await tic.deployed();

  console.log("✅ TicTacToe deployed to:", tic.address);
}

main().catch((error) => {
  console.error("❌ Deployment failed:", error);
  process.exitCode = 1;
});
