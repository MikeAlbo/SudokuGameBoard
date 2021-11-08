import 'dart:async';
import 'dart:math';

import 'package:basic_game/api/repository.dart';
import 'package:basic_game/helpers/enums.dart';
import 'package:basic_game/helpers/game_state_builder.dart';

/// Game Bloc
///
/// The Game bloc handles game generation, and game settings
class GameBloc {
  final _repo = getRepository;
  bool gameBoardsLoaded = false;
  late List<dynamic>? gameBoards;
  GameDifficulty _gameDifficulty = GameDifficulty.easy;
  int _initCompletedTiles = 0;

  GameBloc() {
    gameBoards = null;
    _loadGameBoardDataSet();
  }

  //  TODO: load game board dataset
  Future<List> _loadGameBoardDataSet() async {
    print("load called");
    List<dynamic>? gbs = await _repo.getAllLocalGameBoards;
    gameBoards = gbs;
    gameBoardsLoaded = true;
    return gbs;
  }

  //  TODO: get the length of the entire dataset
  // int _getLengthOfGameBoardSet() {
  //   return gameBoards.length;
  // }

  //  TODO: get a single game board by ID
  Future<List<dynamic>> getGameBoardByID({required int id}) async {
    var gb = gameBoards ?? await _loadGameBoardDataSet();
    print(gb[0]["game_board"]);
    return gb[0]["game_board"];
  }

  //  TODO: get a single game board randomly
  Future<List<dynamic>> getRandomGameBoard() async {
    var gb = gameBoards ?? await _loadGameBoardDataSet();
    int id = Random().nextInt(gb.length);
    print("random int $id");
    print(gb[id]["game_board"]);
    return gb[id]["game_board"];
  }
  //  TODO: handle game settings (theme, etc.)

  //  TODO: handle game play settings (difficulty, etc.)
  void selectDifficulty(GameDifficulty difficulty) {
    _gameDifficulty = difficulty;
    _initCompletedTiles = getNumberOfCompletedTiles(difficulty);
  }

  //  TODO: function that creates a new game board
  //  TODO: function that generates gameBoardStates
  //  TODO: getter that accesses gameBoardState map
  //  TODO: inside widgets ->  create a builder that returns a build gameBoard widget
}
