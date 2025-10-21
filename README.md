# 🎮 BaseChain Tic-Tac-Toe (Morpion)

A **decentralized Tic-Tac-Toe (Morpion)** game deployed on **Base (Coinbase L2)** using **Solidity**, **Hardhat**, and **React**.  
Play against friends directly on-chain with MetaMask, track games, and explore blockchain interactions in a simple but complete dApp.

---

## 🧱 Tech Stack

- **Blockchain**: Base (EVM-compatible L2)  
- **Smart Contracts**: Solidity 0.8.20  
- **Framework**: Hardhat + Ethers.js  
- **Frontend**: React (Vite)  
- **Testing**: Mocha + Chai  
- **CI/CD**: GitHub Actions  

---

## ⚙️ Project Setup

### 1. Clone the repository
```bash
git clone https://github.com/yourusername/basechain-tictactoe.git
cd basechain-tictactoe
```

### 2. Install dependencies
```bash
npm install
```

### 3. Create a `.env` file
Create a `.env` in the root directory and add:

```env
DEPLOYER_PRIVATE_KEY=0xYOUR_PRIVATE_KEY
BASE_RPC_URL=https://mainnet.base.org
BASE_SEPOLIA_RPC=https://sepolia.base.org
ETHERSCAN_API_KEY=YOUR_API_KEY
```

---

## 🧪 Compile & Test

```bash
# Compile contracts
npm run compile

# Run tests
npm test
```

---

## 🚀 Deployment

### Deploy to Base Sepolia (Testnet)
```bash
npm run deploy:sep
```

### Deploy to Base Mainnet
```bash
npm run deploy:main
```

After deployment, copy your contract address and update it in:

```
frontend/src/lib/ethers.ts
export const CONTRACT_ADDRESS = "0xYourContractAddressHere";
```

---

## 🖥️ Frontend

### Run locally
```bash
cd frontend
npm install
npm run dev
```

Open your browser at `http://localhost:5173/` to play.

### Features
- Connect your MetaMask wallet  
- Create a game or join an existing game  
- Play turns on-chain  
- Real-time updates (pending frontend enhancements)  

---

## 📂 Folder Structure

```
basechain-tictactoe/
├── contracts/                # Solidity smart contract
├── scripts/                  # Deployment scripts
├── test/                     # Hardhat tests
├── frontend/                 # React frontend
│   ├── src/
│   │   ├── App.tsx
│   │   ├── main.tsx
│   │   ├── lib/ethers.ts
│   │   └── components/
│   │       ├── Board.tsx
│   │       └── GameControls.tsx
│   └── index.html
├── .github/workflows/        # GitHub CI workflow
├── .gitignore
├── .env.example
├── hardhat.config.ts
├── package.json
└── README.md
```

---

## 🔒 Security Notes

- Never commit your private key to GitHub  
- Use `.env` for sensitive data  
- Test thoroughly on **Base Sepolia** before deploying to **Mainnet**  

---

## 💡 Future Enhancements

- Real-time game updates using events  
- Player matchmaking and lobby system  
- On-chain betting / escrow  
- Game history & leaderboards  
- Gas optimization & contract audit  
- UI improvements with animations  

---

## 🧾 License

**MIT License** – Free to use, modify, and distribute.

© 2025 — BaseChain Tic-Tac-Toe Project
