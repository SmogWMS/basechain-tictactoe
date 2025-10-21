import { ethers } from "ethers";

export const CONTRACT_ADDRESS = "0xYourContractAddressHere";

export const CONTRACT_ABI = [
  "function createGame() external returns (uint)",
  "function joinGame(uint gameId) external",
  "function play(uint gameId, uint8 index) external",
  "function gameCount() view returns (uint)",
  "function getBoard(uint gameId) view returns (uint8[9] memory)"
];

export let provider = null;
export let signer = null;
export let contract = null;

export async function connectWallet() {
  if (!window.ethereum) {
    alert("Please install MetaMask to use this app.");
    return null;
  }

  provider = new ethers.BrowserProvider(window.ethereum);
  const accounts = await provider.send("eth_requestAccounts", []);
  signer = await provider.getSigner();
  contract = new ethers.Contract(CONTRACT_ADDRESS, CONTRACT_ABI, signer);
  return accounts[0];
}
