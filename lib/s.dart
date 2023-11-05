import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Ayar extends StatefulWidget {
  @override
  _AyarState createState() => _AyarState();
}

class _AyarState extends State<Ayar> {
  double volume = 0.5; // Başlangıç ses seviyesi
  Color selectedColor = Colors.lightBlue; // Başlangıçta seçilen renk

  void changeColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Slider(
              value: volume,
              onChanged: (newValue) {
                setState(() {
                  volume = newValue;
                });
              },
            ),
            Text('Ses Seviyesi: ${volume.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Renk Seçici'),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: selectedColor,
                          onColorChanged: changeColor,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text('Renk Seç'),
            ),
            Container(
              color: selectedColor,
              width: 50,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
