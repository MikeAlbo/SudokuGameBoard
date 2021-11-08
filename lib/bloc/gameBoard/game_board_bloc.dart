import 'dart:core';
import 'dart:math';

import 'package:basic_game/api/repository.dart';
import 'package:basic_game/app/widgets/helpers/grid_builder.dart';
import 'package:basic_game/helpers/enums.dart';
import 'package:basic_game/helpers/game_state_builder.dart';
import 'package:basic_game/models/tile_state_model.dart';
import 'package:flutter/material.dart' show BuildContext, TableRow;
import 'package:rxdart/rxdart.dart';

class GameBoardBloc {
  final _repo = getRepository;
  late List<dynamic>? gameBoards;
  GameDifficulty _gameDifficulty = GameDifficulty.easy;
  int _initCompletedTiles = 0;
  final _tileListenerStream = BehaviorSubject<Map<int, TileStateModel>>();
  TileStateModel? _selectedTileValue;
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
  Future<List<dynamic>> _getGameBoardByID({required int id}) async {
    var gb = gameBoards ?? await _loadGameBoardDataSet();
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

  //  TODO: function called by user or game engine to generate a new game board and tile state
  Future<List<TableRow>> generateNewRandomGame(BuildContext context,
      {bool random = false, int id = 0}) async {
    print("get current game");
    List<dynamic> gameBoard = await _getRandomGameBoard();
    Map<int, TileStateModel> mappedStates = buildTileStateMap(
        numberOfCompletedTiles: _initCompletedTiles, gameBoard: gameBoard);
    mappedTilesForCurrentGame = mappedStates;
    List<TableRow> finishedTableRows =
        newGridBuilder(context: context, mappedStates: mappedStates);

    return finishedTableRows;
  }

  // function called by tile, which will add it's TileStateModel  to _selectedTileState
  // if _selectedTileState == addTile, _selectedTileState == null, mapped Tile States updated and added back to stream
  void submitTileStateChange(TileStateModel tsm) {
    print("called by ${tsm.id}");
    TileStateModel newTsm;
    if (tsm.id != _selectedTileValue?.id) {
      _selectedTileValue = tsm;
      switch (tsm.mode) {
        case TileMode.blank:
          newTsm = TileStateModel(
              id: tsm.id, value: tsm.value, mode: TileMode.selected);
          break;
        // case TileMode.complete:
        //   newTsm = TileStateModel(
        //       id: tsm.id, value: tsm.value, mode: TileMode.highlighted);
        //   break;
        // case TileMode.error:
        //   newTsm = TileStateModel(
        //       id: tsm.id, value: tsm.value, mode: TileMode.blank);
        //   break;
        // case TileMode.highlighted:
        //   newTsm = TileStateModel(
        //       id: tsm.id, value: tsm.value, mode: TileMode.complete);
        //   break;
        case TileMode.selected:
          newTsm = TileStateModel(
              id: tsm.id, value: tsm.value, mode: TileMode.blank);
          break;
        default:
          newTsm = TileStateModel(
              id: tsm.id, value: tsm.value, mode: TileMode.error);
      }
    } else {
      _selectedTileValue = null;
      newTsm = newTsm =
          TileStateModel(id: tsm.id, value: tsm.value, mode: TileMode.blank);
    }
    _updateMapAndAddToStream(newTsm);
  }

  void _updateMapAndAddToStream(TileStateModel updatedTsm) {
    print(
        "updatedTSM: id: ${updatedTsm.id}, value: ${updatedTsm.value}, mode: ${updatedTsm.mode}");
    print("from map: ${mappedTilesForCurrentGame[updatedTsm.id]?.id}");
    print(
        "after update: id: ${mappedTilesForCurrentGame[updatedTsm.id]?.id}, mode: ${mappedTilesForCurrentGame[updatedTsm.id]?.mode}");
    mappedTilesForCurrentGame.update(updatedTsm.id, (value) => updatedTsm);
    print(
        "after update: id: ${mappedTilesForCurrentGame[updatedTsm.id]?.id}, mode: ${mappedTilesForCurrentGame[updatedTsm.id]?.mode}");
    _tileListenerStream.add(mappedTilesForCurrentGame);
  }

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
