import React from 'react';

export default function GameControls({ onCreate, onJoin, gameId }: any) {
  return (
    <div style={{ marginTop: '20px' }}>
      <button onClick={onCreate}>Create Game</button>
      <input type="number" value={gameId} onChange={(e) => onJoin(e.target.value)} placeholder="Game ID"/>
      <button onClick={() => onJoin(gameId)}>Join Game</button>
    </div>
  );
}
