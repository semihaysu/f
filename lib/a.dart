import 'package:flutter/material.dart';
import 'y.dart';
import 'n.dart';
import 'n4.dart';
import 'n5.dart';

class Secenek extends StatefulWidget {
  @override
  _SecenekState createState() => _SecenekState();
}

class _SecenekState extends State<Secenek> {
  double buttonSize = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                minimumSize: Size(buttonSize, buttonSize),
              ),
              onPressed: () {
                _showMessageBox(
                    context, "Lütfen Seçim Yapınız", "", ["3x3", "4x4", "5x5"]);
              },
              child: Text(
                '  Arkadaşınla Oyna  ',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                minimumSize: Size(buttonSize, buttonSize),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TicTacToeGameYapay()),
                );
              },
              child: Text(
                'Yapay Zeka İle Oyna',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessageBox(BuildContext context, String title, String content,
      List<String> options) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: Text(
            content,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: options.map((option) {
            return TextButton(
              onPressed: () {
                Navigator.pop(context);
                _handleMessageBoxOption(context, option);
              },
              child: Text(
                option,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _handleMessageBoxOption(BuildContext context, String option) {
    if (option == "3x3") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TicTacToeGame()),
      );
    } else if (option == "4x4") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TicTacToe4Game()),
      );
    } else if (option == "5x5") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TicTacToe5Game()),
      );
    }
  }
}
