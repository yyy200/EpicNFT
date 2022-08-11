import { HardhatUserConfig } from "hardhat/config";
require("dotenv").config({ path: ".env" });

import "@nomiclabs/hardhat-ethers";
import "@nomicfoundation/hardhat-chai-matchers";

const config: HardhatUserConfig = {
  solidity: "0.8.9",
  networks: {
    rinkeby: {
      url: process.env.QUICKNODE_API_KEY_URL,
      accounts: [process.env.RINKEBY_PRIVATE_KEY ?? ""],
    },
  },
};

export default config;
