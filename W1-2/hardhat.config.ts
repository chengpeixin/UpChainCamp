import {HardhatUserConfig} from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import Dotenv from "dotenv";

Dotenv.config();
const {PRIVATE_KEY, SCROLL_TESTNET_URL} = process.env

const config: HardhatUserConfig = {
    solidity: "0.8.18",
    networks: {
        development: {
            gas: 2100000,
            gasPrice: 8000000000,
            url: "http://127.0.0.1:8545",
            chainId: 31337
        },
        scrollTestnet: {
            url: SCROLL_TESTNET_URL,
            accounts: [PRIVATE_KEY as string]
        }
    }
};

export default config;
