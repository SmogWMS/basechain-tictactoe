// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TicTacToeV2 {
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

    event GameCreated(uint indexed gameId, address indexed creator);
    event PlayerJoined(uint indexed gameId, address indexed player);
    event MovePlayed(uint indexed gameId, address indexed player, uint8 index);
    event GameEnded(uint indexed gameId, Status result);
    event Resigned(uint indexed gameId, address indexed player, Status result);

    // Crée une partie : msg.sender est X et commence
    function createGame() external returns (uint gameId) {
        gameId = ++gameCount;
        Game storage g = games[gameId];
        g.playerX = msg.sender;
        g.turn = msg.sender;
        g.status = Status.WaitingForPlayer;
        emit GameCreated(gameId, msg.sender);
    }

    // Rejoindre comme O
    function joinGame(uint gameId) external {
        Game storage g = games[gameId];
        require(g.playerX != address(0), "no such game");
        require(g.playerO == address(0), "game full");
        require(g.playerX != msg.sender, "creator can't join as O");

        g.playerO = msg.sender;
        g.status = Status.InProgress;

        emit PlayerJoined(gameId, msg.sender);
    }

    // Jouer un coup
    function play(uint gameId, uint8 index) external {
        require(index < 9, "invalid index");
        Game storage g = games[gameId];
        require(g.status == Status.InProgress, "game not in progress");
        require(msg.sender == g.turn, "not your turn");

        Cell marker = (msg.sender == g.playerX) ? Cell.X : Cell.O;

        require(
            (marker == Cell.X && msg.sender == g.playerX) ||
            (marker == Cell.O && msg.sender == g.playerO),
            "not a player"
        );

        require(g.board[index] == Cell.Empty, "cell occupied");

        g.board[index] = marker;
        emit MovePlayed(gameId, msg.sender, index);

        Status s = _evaluate(g.board);
        if (s == Status.XWon || s == Status.OWon || s == Status.Draw) {
            g.status = s;
            // Optionnel: clarifier le tour une fois fini
            g.turn = address(0);
            emit GameEnded(gameId, s);
            return;
        }

        // Alterne le tour
        g.turn = (g.turn == g.playerX) ? g.playerO : g.playerX;
    }

    // Abandonner la partie
    function resign(uint gameId) external {
        Game storage g = games[gameId];
        require(g.status == Status.InProgress, "game not in progress");
        require(msg.sender == g.playerX || msg.sender == g.playerO, "not a player");

        if (msg.sender == g.playerX) {
            g.status = Status.OWon;
            emit Resigned(gameId, msg.sender, Status.OWon);
        } else {
            g.status = Status.XWon;
            emit Resigned(gameId, msg.sender, Status.XWon);
        }
        g.turn = address(0);
        emit GameEnded(gameId, g.status);
    }

    // Récupérer la grille
    function getBoard(uint gameId) external view returns (Cell[9] memory) {
        return games[gameId].board;
    }

    // Infos pratiques pour le front
    function getInfo(uint gameId)
        external
        view
        returns (
            address playerX,
            address playerO,
            address turn,
            Status status
        )
    {
        Game storage g = games[gameId];
        return (g.playerX, g.playerO, g.turn, g.status);
    }

    // Évalue l'état d'une grille
    function _evaluate(Cell[9] memory b) internal pure returns (Status) {
        // 8 combinaisons gagnantes, chacune 3 indices
        uint8[3][8] memory wins = [
            [uint8(0), 1, 2],
            [uint8(3), 4, 5],
            [uint8(6), 7, 8],
            [uint8(0), 3, 6],
            [uint8(1), 4, 7],
            [uint8(2), 5, 8],
            [uint8(0), 4, 8],
            [uint8(2), 4, 6]
        ];

        for (uint8 i = 0; i < 8; i++) {
            (uint8 a, uint8 c, uint8 d) = (wins[i][0], wins[i][1], wins[i][2]);
            if (b[a] != Cell.Empty && b[a] == b[c] && b[a] == b[d]) {
                return b[a] == Cell.X ? Status.XWon : Status.OWon;
            }
        }

        // Plateau plein ?
        for (uint8 i = 0; i < 9; i++) {
            if (b[i] == Cell.Empty) {
                return Status.InProgress;
            }
        }
        return Status.Draw;
    }
}
