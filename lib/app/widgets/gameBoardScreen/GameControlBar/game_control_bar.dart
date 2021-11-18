//  TODO: should have a button that toggles notes mode
//  TODO: should have a button that toggles full screen
//  TODO: should have an undo function **
//  TODO: should have an erase feature **
//  TODO: should offer hints **

import 'package:flutter/material.dart';

class GameControlBar extends StatelessWidget {
  const GameControlBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border.all(color: Colors.blueAccent, width: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton(icon: Icons.notes, title: "notes", callback: () {}),
            _buildButton(
                icon: Icons.fullscreen,
                title: "full screen",
                callback: () {}), // should be moved to appBar
            _buildButton(icon: Icons.undo, title: "undo", callback: () {}),
            _buildButton(icon: Icons.edit, title: "erase", callback: () {}),
          ],
        ),
      ),
    );
  }
}

TextButton _buildButton(
    {required IconData icon,
    required String title,
    required VoidCallback callback}) {
  return TextButton(
      onPressed: callback,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          Text(title),
        ],
      ));
}
