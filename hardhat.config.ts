import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";
dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {
    celo: {
      url: process.env.CELO_RPC_URL || "https://forno.celo.org",
      accounts: [process.env.DEPLOYER_PRIVATE_KEY || ""],
      chainId: 42220,
    },
    alfajores: {
      url: process.env.CELO_ALFAJORES_RPC_URL || "https://alfajores-forno.celo-testnet.org",
      accounts: [process.env.DEPLOYER_PRIVATE_KEY || ""],
      chainId: 44787,
    },
  },
  etherscan: {
    apiKey: process.env.CELOSCAN_API_KEY,
  },
};

export default config;
