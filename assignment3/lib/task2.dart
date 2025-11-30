import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  // plays the sound file from the assets/sounds folder
  void playSound(String file) {
    final player = AudioPlayer();

    player.play(AssetSource('sounds/$file'));
  }

  // Build a single rectangular, expanded key (tile) for the xylophone.
  Expanded _tile({required Color color, required String file}) {
    return Expanded(
      // the TextButton provides the tap function and the rectangular shape
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          // use a rectangular shape
          shape: const BeveledRectangleBorder(),
        ),
        // calls playSound when the tile is pressed
        onPressed: () => playSound(file),
        // empty child for a clean, solid colored tile
        child: const SizedBox.shrink(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,

        appBar: AppBar(
          title: const Text(
            "Flutter Xylophone",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),

        // column holds the keys and uses CrossAxisAlignment.stretch
        // to ensure they fill the width
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // using the helper function _tile
            _tile(color: Colors.red, file: "do.wav"),
            _tile(color: Colors.orange, file: "re.wav"),
            _tile(color: Colors.yellow, file: "mi.wav"),
            _tile(color: Colors.green, file: "fa.wav"),
            _tile(color: Colors.teal, file: "sol.wav"),
            _tile(color: Colors.blue, file: "la.wav"),
            _tile(color: Colors.purple, file: "si.wav"),
          ],
        ),
      ),
    );
  }
}
