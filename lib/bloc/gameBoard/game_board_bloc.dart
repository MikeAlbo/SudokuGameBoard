import 'dart:core';
import 'dart:math';

import 'package:basic_game/api/repository.dart';
import 'package:basic_game/app/widgets/helpers/grid_builder.dart';
import 'package:basic_game/helpers/enums.dart';
import 'package:basic_game/helpers/game_state_builder.dart';
import 'package:basic_game/models/game_tile_model.dart';
import 'package:basic_game/models/tile_state_model.dart';
import 'package:flutter/material.dart' show BuildContext, TableRow;
import 'package:rxdart/rxdart.dart';

class GameBoardBloc {
  final _repo = getRepository;
  late List<dynamic>? gameBoards;
  GameDifficulty _gameDifficulty = GameDifficulty.easy;
  int _initCompletedTiles = 0;
  final _tileListenerStream = BehaviorSubject<Map<int, TileStateModel>>();
  GameTileModel? _selectedTileValue;
  late Map<int, TileStateModel> mappedTilesForCurrentGame;

  // getter for listening for correct answer
  Stream<Map<int, TileStateModel>> get tileListener =>
      _tileListenerStream.stream;

  GameBoardBloc() {
    gameBoards = null;
    print("game board created");
    // _loadGameBoardDataSet();
  }

  // load game board dataset
  Future<List> _loadGameBoardDataSet() async {
    print("load called");
    List<dynamic>? gbs = await _repo.getAllLocalGameBoards;
    gameBoards = gbs;
    return gbs;
  }

  // get a single game board by ID
  Future<List<dynamic>> getGameBoardByID({required int id}) async {
    var gb = gameBoards ?? await _loadGameBoardDataSet();
    print(gb[0]["game_board"]);
    return gb[0]["game_board"];
  }

  // get a single game board randomly
  Future<List<dynamic>> _getRandomGameBoard() async {
    var gb = gameBoards ?? await _loadGameBoardDataSet();
    int id = Random().nextInt(gb.length);
    return gb[id]["game_board"];
  }

  // select difficulty of game, called by UI element. Also, should be saved in the suer prefs
  // retrieves the number of completed tiles needed per difficulty selected
  void selectDifficulty(GameDifficulty difficulty) {
    //  TODO: this function should call a repo function to update the user prefs
    _gameDifficulty = difficulty;
    _initCompletedTiles = getNumberOfCompletedTiles(difficulty);
  }

  //  TODO: (if blank) function to add a tile to _selectedTileValue -> updates TileState -> adds to stream
  _handleBlankTileSubmitted(GameTileModel tileModel) {
    _selectedTileValue = _selectedTileValue == null ? tileModel : null;
  }

  //  TODO: function called by user or game engine to generate a new game board and tile state

  //  TODO: inside widgets ->  create a builder that returns a build gameBoard widget

  //  TODO: below functions should be private, create a public method that handles the request from the tile
  Future<List<TableRow>> getCurrentGame(BuildContext context,
      {bool random = false, int id = 0}) async {
    print("get current game");
    List<dynamic> gameBoard = await _getRandomGameBoard();
    Map<int, TileStateModel> mappedStates = buildTileStateMap(
        numberOfCompletedTiles: _initCompletedTiles, gameBoard: gameBoard);
    mappedTilesForCurrentGame = mappedStates;
    List<TableRow> finishedTableRows =
        newGridBuilder(context: context, mappedStates: mappedStates);
    // List<TableRow> finishedTableRows = gridBuilder(9, 9, context, mappedStates);

    return finishedTableRows;
  }

  //  TODO: function that creates a new game board, if needed, Should be able to call getGameBoard

  //  TODO: function to remove tile from _selectedTileValue -> updateStream ->
  //  TODO: function that takes an int, if _selectedTileValue -> compares -> updates TileState -> adds to stream
  //  TODO: function that generates gameBoardStates
  //  TODO: getter that accesses gameBoardState map
  //  TODO: (if complete) function that finds all tiles with same value, marks them as TileMode.highlighted
  //  TODO: handle game settings (theme, etc.)
  dispose() {
    _tileListenerStream.close();
  }
}
