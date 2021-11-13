import 'dart:async';
import 'dart:core';
import 'dart:math';

import 'package:basic_game/api/repository.dart';
import 'package:basic_game/app/game_engine.dart';
import 'package:basic_game/app/widgets/helpers/grid_builder.dart';
import 'package:basic_game/helpers/enums.dart';
import 'package:basic_game/models/tile_state_model.dart';
import 'package:flutter/material.dart' show BuildContext, TableRow;
import 'package:rxdart/rxdart.dart';

Completer _completer = Completer();
Future get ready => _completer.future;

class GameBoardBloc {
  final _repo = getRepository;
  late GameEngine _gameEngine;
  GameDifficulty _gameDifficulty = GameDifficulty.easy;
  final _tileListenerStream = BehaviorSubject<Map<int, TileStateModel>>();

  // getter for listening for correct answer
  Stream<Map<int, TileStateModel>> get tileListener =>
      _tileListenerStream.stream;

  GameBoardBloc() {
    print("game board created");
    // _loadGameBoardDataSet();
  }

  void setupNewGame({required GameDifficulty difficulty}) async {
    _gameEngine = GameEngine();
    List<dynamic> gameBoard = await _getRandomGameBoard();
    _gameDifficulty = difficulty;
    _gameEngine.initializeGame(
      gameBoardData: gameBoard,
      difficulty: difficulty,
    );
    if (!_completer.isCompleted) {
      _completer.complete();
    }
  }

  void createNewGame() async {
    _completer = Completer();
    _gameEngine = GameEngine();
    setupNewGame(difficulty: _gameDifficulty);
    await ready;
    _tileListenerStream.add(_gameEngine.getNewGameState);
  }

  // get a single game board by ID
  // Future<List<dynamic>> _getGameBoardByID({required int id}) async {
  //   var gb = gameBoards ?? await _loadGameBoardDataSet();
  //   return gb[0]["game_board"];
  // }

  // get a single game board randomly
  Future<List<dynamic>> _getRandomGameBoard() async {
    var gb = await _repo.getAllLocalGameBoards;
    int id = Random().nextInt(gb.length);
    print("gameboard id: $id");
    return gb[id]["game_board"];
  }

  // select difficulty of game, called by UI element. Also, should be saved in the suer prefs
  // retrieves the number of completed tiles needed per difficulty selected
  void selectDifficulty(GameDifficulty difficulty) {
    //  TODO: this function should call a repo function to update the user prefs
    _gameDifficulty = difficulty;
    _gameEngine.setGameDifficulty = difficulty;
  }

  //  TODO: function called by user or game engine to generate a new game board and tile state
  Future<List<TableRow>> generateNewRandomGame(BuildContext context,
      {bool random = false, int id = 0}) async {
    await ready;
    Map<int, TileStateModel> mappedStates = _gameEngine.getNewGameState;
    List<TableRow> finishedTableRows =
        newGridBuilder(context: context, mappedStates: mappedStates);

    return finishedTableRows;
  }

  void updateSelectedTile(TileStateModel tileStateModel) async {
    await ready;
    Map<int, TileStateModel> updatedMappedTileStateModes;
    if (tileStateModel.mode == TileMode.complete) {
      updatedMappedTileStateModes =
          _gameEngine.updateCompletedTiles(tileStateModel);
    } else {
      updatedMappedTileStateModes =
          _gameEngine.updateCompletedTiles(tileStateModel);
    }
    _tileListenerStream.add(updatedMappedTileStateModes);
  }

  dispose() {
    _tileListenerStream.close();
  }
}
