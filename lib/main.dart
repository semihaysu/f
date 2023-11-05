import 'package:flutter/material.dart';
import 'a.dart';
import 's.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(
                      20.0), // Ayarların boyutunu büyütmek için padding'i artırın
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Ayar()),
                      );
                    },
                    icon: Icon(
                      Icons.settings,
                      size: 36,
                      color: Colors.black,
                    ), // Boyutu artırmak için size ekledik
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Secenek()),
                        );
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.play_arrow,
                            size: 60, // Boyutu artırmak için size ekledik
                          ),
                          Text(
                            'Başla',
                            style: TextStyle(
                              fontFamily: 'calibri',
                              fontSize:
                                  30, // Boyutu artırmak için fontSize'u artırın
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(
                            40), // Başlat butonunun boyutunu ayarlamak için padding'i artırın
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
