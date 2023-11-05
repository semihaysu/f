import 'package:flutter/material.dart';
import 'dart:async';

class TicTacToe5Game extends StatefulWidget {
  @override
  _TicTacToe5GameState createState() => _TicTacToe5GameState();
}

class _TicTacToe5GameState extends State<TicTacToe5Game> {
  List<String> board = List.filled(25, " ");
  bool xTurn = true;
  int xSeconds = 10;
  int oSeconds = 10;
  int totalSeconds = 0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (mounted) {
        setState(() {
          totalSeconds++;
          if (xTurn) {
            xSeconds--;
            if (xSeconds == 0) {
              xTurn = false;
              xSeconds = 10;
            }
          } else {
            oSeconds--;
            if (oSeconds == 0) {
              xTurn = true;
              oSeconds = 10;
            }
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
                      "Süre: ${xTurn ? xSeconds : oSeconds}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                Text(
                  "Süre: $totalSeconds saniye",
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
                      "Süre: ${xTurn ? oSeconds : xSeconds}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ],
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemCount: 25,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (board[index] == " " &&
                        !checkWin("X") &&
                        !checkWin("O")) {
                      setState(() {
                        if (xTurn) {
                          board[index] = "X";
                        } else {
                          board[index] = "O";
                        }
                        xTurn = !xTurn;
                      });
                      if (!checkWin("X") &&
                          !checkWin("O") &&
                          board.indexOf(" ") == -1) {
                        showResult("Berabere!");
                        resetGame();
                      } else if (checkWin("X")) {
                        showResult("Oyuncu X kazandı!");
                        resetGame();
                      } else if (checkWin("O")) {
                        showResult("Oyuncu O kazandı!");
                        resetGame();
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
      [0, 1, 2, 3, 4],
      [5, 6, 7, 8, 9],
      [10, 11, 12, 13, 14],
      [15, 16, 17, 18, 19],
      [20, 21, 22, 23, 24],
      [0, 5, 10, 15, 20],
      [1, 6, 11, 16, 21],
      [2, 7, 12, 17, 22],
      [3, 8, 13, 18, 23],
      [4, 9, 14, 19, 24],
      [0, 6, 12, 18, 24],
      [4, 8, 12, 16, 20],
    ];

    for (var combo in winCombinations) {
      if (combo.every((index) => board[index] == player)) {
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
                Navigator.of(context).pop();
              },
              child: Text("Tamam"),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    board = List.filled(25, " ");
    xTurn = true;
    xSeconds = 10;
    oSeconds = 10;
    totalSeconds = 0;
  }
}

void main() {
  runApp(MaterialApp(home: TicTacToe5Game()));
}
