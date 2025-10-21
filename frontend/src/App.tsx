import React, { useState } from 'react';
import { connectWallet } from './lib/ethers';

export default function App(){
  const [account, setAccount] = useState<string | null>(null);

  return (
    <div className="p-6">
      <h1 className="text-2xl">Tic-Tac-Toe on Base</h1>
      <button onClick={async()=>{ const a = await connectWallet(); setAccount(a); }}>
        {account ? account : 'Connect Wallet'}
      </button>
    </div>
  )
}
