
import { expect } from "chai";
import { ethers } from "hardhat";

describe("TicTacToe", function () {
  it("should create, join, and play a game to completion", async function () {
    const [a, b] = await ethers.getSigners();
    const Tic = await ethers.getContractFactory("TicTacToe", a);
    const tic = await Tic.deploy();
    await tic.deployed();

    await tic.connect(a).createGame();
    const gameId = 1;

    await tic.connect(b).joinGame(gameId);
    await tic.connect(a).play(gameId, 0);
    await tic.connect(b).play(gameId, 1);
    await tic.connect(a).play(gameId, 4);
    await tic.connect(b).play(gameId, 2);
    await tic.connect(a).play(gameId, 8);
  

    const g = await tic.games(gameId);
    expect(g.status).to.not.equal(1);
      npx hardhat run scripts/deploy.ts --network alfajores
  });
});
