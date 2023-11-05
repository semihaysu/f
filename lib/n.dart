import 'package:flutter/material.dart';
import 'dart:async';

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> board = List.filled(9, " ");
  bool xTurn = true;
  int xSeconds = 10;
  int oSeconds = 10;
  int Seconds = 0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (mounted) {
        setState(() {
          Seconds++;
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
                  "Süre: ${Seconds} saniye",
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
                crossAxisCount: 3,
              ),
              itemCount: 9,
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
                          xTurn = false;
                          xSeconds = 10;
                        } else {
                          board[index] = "O";
                          xTurn = true;
                          oSeconds = 10;
                        }
                      });
                      if (!checkWin("X") &&
                          !checkWin("O") &&
                          board.indexOf(" ") == -1) {
                        showResult("Berabere!");
                        setState(() {
                          xSeconds = 10;
                          oSeconds = 10;
                        });
                      } else if (checkWin("X")) {
                        showResult("Oyuncu X kazandı!");
                        setState(() {
                          xSeconds = 10;
                          oSeconds = 10;
                        });
                      } else if (checkWin("O")) {
                        showResult("Oyuncu O kazandı!");
                        setState(() {
                          xSeconds = 10;
                          oSeconds = 10;
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
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in winCombinations) {
      if (board[combo[0]] == player &&
          board[combo[1]] == player &&
          board[combo[2]] == player) {
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
                  board = List.filled(9, " ");
                  xTurn = true;
                  xSeconds = 10;
                  oSeconds = 10;
                  Seconds = 0;
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
}

void main() {
  runApp(MaterialApp(home: TicTacToeGame()));
}
