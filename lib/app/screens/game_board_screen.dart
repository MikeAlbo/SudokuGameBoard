import 'package:flutter/material.dart';

class GameBoardScreen extends StatefulWidget {
  const GameBoardScreen({Key? key}) : super(key: key);

  @override
  State<GameBoardScreen> createState() => _GameBoardScreenState();
}

class _GameBoardScreenState extends State<GameBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        color: Colors.blue.shade100,
        width: 500.0,
        height: 300.0,
        child: const Center(
          child: Text(
            "GameBoard Screen",
            style: TextStyle(fontSize: 50.0),
          ),
        ),
      ),
    ));
  }
}

//  TODO: remove placeholder widget
//  TODO: add widget to represent game board
//  TODO: add widget to represent appBar
