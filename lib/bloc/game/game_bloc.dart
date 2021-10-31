import 'dart:math';

import 'package:basic_game/api/repository.dart';

/// Game Bloc
///
/// The Game bloc handles game generation, and game settings
class GameBloc {
  final _repo = getRepository;
  bool gameBoardsLoaded = false;
  late List<dynamic>? gameBoards;

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
    return gb;
  }

  //  TODO: get a single game board randomly
  Future<List<dynamic>> getRandomGameBoard() async {
    var gb = gameBoards ?? await _loadGameBoardDataSet();
    int id = Random().nextInt(gb.length);
    return getGameBoardByID(id: id);
  }
  //  TODO: handle game settings (theme, etc.)
  //  TODO: handle game play settings (difficulty, etc.)
}
