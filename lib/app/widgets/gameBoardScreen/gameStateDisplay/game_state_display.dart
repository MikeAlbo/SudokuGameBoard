//  TODO: a button to create a new game
//  TODO: a text field to display the current game difficulty
//  TODO: a game timer with a pause/ play button
//  TODO: a score counter should be a widget that updates as the score increments

import 'package:basic_game/helpers/enums.dart';
import 'package:flutter/material.dart';

class GameStateDisplay extends StatelessWidget {
  final GameDifficulty gameDifficulty;
  final VoidCallback createNewGame;

  const GameStateDisplay(
      {Key? key, required this.createNewGame, required this.gameDifficulty})
      : super(key: key);

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
                onPressed: createNewGame,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add),
                    Text("New Game"),
                  ],
                )),
            Text(
              _renderGameDifficulty(difficulty: gameDifficulty),
              style: const TextStyle(color: Colors.black45),
            ),
            const Text("00:45 ||"),
            const Text("SCORE: 25,000")
          ],
        ),
      ),
    );
  }
}

String _renderGameDifficulty({required GameDifficulty difficulty}) {
  switch (difficulty) {
    case GameDifficulty.easy:
      return "easy";
    case GameDifficulty.medium:
      return "medium";
    case GameDifficulty.hard:
      return "hard";
    case GameDifficulty.advanced:
      return "advanced";
  }
}
