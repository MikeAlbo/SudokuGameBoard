import 'package:basic_game/helpers/enums.dart';
import 'package:basic_game/models/tile_state_model.dart';

const List<List<dynamic>> mockGameBoardData = [
  [1, 2, 3, 4, 5, 6, 7, 8, 9],
  [2, 3, 4, 5, 6, 7, 8, 9, 1],
  [3, 4, 5, 6, 7, 8, 9, 1, 2],
  [4, 5, 6, 7, 8, 9, 1, 2, 3],
  [5, 6, 7, 8, 9, 1, 2, 3, 4],
  [6, 7, 8, 9, 1, 2, 3, 4, 5],
  [7, 8, 9, 1, 2, 3, 4, 5, 6],
  [8, 9, 1, 2, 3, 4, 5, 6, 7],
  [9, 1, 2, 3, 4, 5, 6, 7, 8]
];

//  TODO: map<int, TileMode> to store a list of mapped states
// temp, will probably not need in this file
Map<int, TileStateModel> mappedStates = {};

//  TODO: function that determines how many completed tiles needed based on user selection
int getNumberOfCompletedTiles(GameDifficulty difficulty) {
  switch (difficulty) {
    case GameDifficulty.easy:
      return 50;
    case GameDifficulty.medium:
      return 40;
    case GameDifficulty.hard:
      return 30;
    case GameDifficulty.advanced:
      return 20;
  }
}

// generate a randomized list of t/f
List<bool> generateRandomList(
    {required int numberTrue, required int totalNeeded}) {
  List<bool> randomizedTrue = List.filled(numberTrue, true);
  randomizedTrue += List.filled(totalNeeded - numberTrue, false);
  randomizedTrue.shuffle();
  return randomizedTrue;
}

//  TODO: function that takes in a game bord data set and returns a map<int, TileStateModel>
Map<int, TileStateModel> buildTileStateMap(
    {List<dynamic> gameBoard = mockGameBoardData,
    required int numberOfCompletedTiles}) {
  // randomized t/f values t == complete, f == blank
  List<bool> randomizedTrue =
      generateRandomList(numberTrue: numberOfCompletedTiles, totalNeeded: 81);

  Map<int, TileStateModel> tempMap = {};
  int id = 0;
  // loop through game board and build map<int, TileState>
  for (var row = 0; row < gameBoard.length; row++) {
    for (var col = 0; col < gameBoard[row].length; col++) {
      id++;
      tempMap[id] = TileStateModel(
        id: id,
        value: gameBoard[row][col],
        mode:
            randomizedTrue[id - 1] == true ? TileMode.complete : TileMode.blank,
      );
    }
  }
  return tempMap;
}

//  TODO: refactor Answer stream, with new name and ability to accept map<int, TileMode>
//  TODO: function to derive the layout of the tiles -> own file, under widgets
