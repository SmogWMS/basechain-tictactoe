// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TicTacToe {
    enum Cell { Empty, X, O }
    enum Status { WaitingForPlayer, InProgress, XWon, OWon, Draw }

    struct Game {
        address playerX;
        address playerO;
        Cell[9] board;
        address turn;
        Status status;
    }

    uint public gameCount;
    mapping(uint => Game) public games;

    event GameCreated(uint gameId, address creator);
    event PlayerJoined(uint gameId, address player);
    event MovePlayed(uint gameId, address player, uint8 index);
    event GameEnded(uint gameId, Status result);

    function createGame() external returns (uint) {
        gameCount++;
        Game storage g = games[gameCount];
        g.playerX = msg.sender;
        g.turn = msg.sender;
        g.status = Status.WaitingForPlayer;
        emit GameCreated(gameCount, msg.sender);
        return gameCount;
    }

    function joinGame(uint gameId) external {
        Game storage g = games[gameId];
        require(g.playerX != address(0), "no such game");
        require(g.playerO == address(0), "game full");
        require(g.playerX != msg.sender, "creator can't join as O");
        g.playerO = msg.sender;
        g.status = Status.InProgress;
        emit PlayerJoined(gameId, msg.sender);
    }

    function play(uint gameId, uint8 index) external {
        require(index < 9, "invalid index");
        Game storage g = games[gameId];
        require(g.status == Status.InProgress, "game not in progress");
        require(msg.sender == g.turn, "not your turn");

        Cell marker = (msg.sender == g.playerX) ? Cell.X : Cell.O;
        require(g.board[index] == Cell.Empty, "cell occupied");
        g.board[index] = marker;

        emit MovePlayed(gameId, msg.sender, index);

        Status s = _evaluate(g.board);
        if (s == Status.XWon || s == Status.OWon || s == Status.Draw) {
            g.status = s;
            emit GameEnded(gameId, s);
            return;
        }

        g.turn = (g.turn == g.playerX) ? g.playerO : g.playerX;
    }

    function getBoard(uint gameId) external view returns (Cell[9] memory) {
        return games[gameId].board;
    }

    function _evaluate(Cell[9] memory b) internal pure returns (Status) {
        uint[8][3] memory lines = [
            [uint(0),1,2], [3,4,5], [6,7,8]
        ];
        uint[8][3] memory wins = [
            [uint(0),1,2], [3,4,5], [6,7,8], [0,3,6],
            [1,4,7], [2,5,8], [0,4,8], [2,4,6]
        ];

        for (uint i = 0; i < 8; i++) {
            uint a = wins[i][0];
            uint b1 = wins[i][1];
            uint c = wins[i][2];
            if (b[a] != Cell.Empty && b[a] == b[b1] && b[a] == b[c]) {
                return b[a] == Cell.X ? Status.XWon : Status.OWon;
            }
        }

        bool full = true;
        for (uint i = 0; i < 9; i++) {
            if (b[i] == Cell.Empty) { full = false; break; }
        }
        if (full) return Status.Draw;
        return Status.InProgress;
    }
}
