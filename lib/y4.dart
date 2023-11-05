import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MaterialApp(home: TicTacToeGameYapay4()));
}

class TicTacToeGameYapay4 extends StatefulWidget {
  @override
  _TicTacToeGameYapay4State createState() => _TicTacToeGameYapay4State();
}

class _TicTacToeGameYapay4State extends State<TicTacToeGameYapay4> {
  List<String> board = List.filled(16, " ");
  bool xTurn = true;
  int xSeconds = 10;
  int oSeconds = 10;
  int seconds = 0;

  bool checkGameOver() {
    return checkWin("X") || checkWin("O") || board.indexOf(" ") == -1;
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (mounted) {
        setState(() {
          seconds++;
          if (xTurn) {
            xSeconds--;
          } else {
            oSeconds--;
          }
          if (xSeconds == 0 && xTurn) {
            xTurn = false;
            xSeconds = 10;
          } else if (oSeconds == 0 && !xTurn) {
            xTurn = true;
            oSeconds = 10;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.close,
                      size: 50.0,
                      color: Colors.black,
                    ),
                    Text(
                      "X",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      "Süre: $xSeconds",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                Text(
                  "Süre: $seconds saniye",
                  style: TextStyle(fontSize: 20.0),
                ),
                Column(
                  children: [
                    Icon(
                      Icons.radio_button_unchecked,
                      size: 50.0,
                      color: Colors.red,
                    ),
                    Text(
                      "O",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      "Süre: $oSeconds",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ],
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: 16,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (board[index] == " " &&
                        !checkGameOver() &&
                        (xTurn || !xTurn && board.indexOf("O") == -1)) {
                      setState(() {
                        if (xTurn) {
                          board[index] = "X";
                        } else {
                          board[index] = "O";
                        }
                        xTurn = !xTurn;
                        xSeconds = 10;
                        oSeconds = 10;
                      });
                      if (checkWin("X")) {
                        showResult("Oyuncu X kazandı!");
                      } else if (checkWin("O")) {
                        showResult("Oyuncu O kazandı!");
                      } else if (board.indexOf(" ") == -1) {
                        showResult("Berabere!");
                      }

                      if (!xTurn && !checkGameOver()) {
                        int bestMove = findBestMove(board);
                        Timer(Duration(seconds: 1), () {
                          setState(() {
                            board[bestMove] = "O";
                            xTurn = true;
                            oSeconds = 10;
                            if (checkWin("X")) {
                              showResult("Oyuncu X kazandı!");
                            } else if (checkWin("O")) {
                              showResult("Oyuncu O kazandı!");
                            } else if (board.indexOf(" ") == -1) {
                              showResult("Berabere!");
                            }
                          });
                        });
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 4.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(fontSize: 50.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  bool checkWin(String player) {
    List<List<int>> winCombinations = [
      [0, 1, 2, 3],
      [4, 5, 6, 7],
      [8, 9, 10, 11],
      [12, 13, 14, 15],
      [0, 4, 8, 12],
      [1, 5, 9, 13],
      [2, 6, 10, 14],
      [3, 7, 11, 15],
      [0, 5, 10, 15],
      [3, 6, 9, 12],
    ];

    for (var combo in winCombinations) {
      if (board[combo[0]] == player &&
          board[combo[1]] == player &&
          board[combo[2]] == player &&
          board[combo[3]] == player) {
        return true;
      }
    }
    return false;
  }

  void showResult(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sonuç"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  board = List.filled(16, " ");
                  xTurn = true;
                  xSeconds = 10;
                  oSeconds = 10;
                  seconds = 0;
                });
                Navigator.of(context).pop();
              },
              child: Text("Yeniden Başla"),
            ),
          ],
        );
      },
    );
  }

  int minimax(List<String> board, String player) {
    if (checkWin(player)) {
      if (player == "X") {
        return -1;
      } else {
        return 1;
      }
    } else if (board.indexOf(" ") == -1) {
      return 0;
    }

    if (player == "O") {
      int bestScore = -1000;
      for (int i = 0; i < 16; i++) {
        if (board[i] == " ") {
          board[i] = player;
          int score = minimax(board, "X");
          board[i] = " ";
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < 16; i++) {
        if (board[i] == " ") {
          board[i] = player;
          int score = minimax(board, "O");
          board[i] = " ";
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
  }

  int findBestMove(List<String> board) {
    int bestScore = -1000;
    int bestMove = -1;
    for (int i = 0; i < 16; i++) {
      if (board[i] == " ") {
        board[i] = "O";
        int score = minimax(board, "X");
        board[i] = " ";
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }
    return bestMove;
  }
}
