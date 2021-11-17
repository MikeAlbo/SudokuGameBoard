import 'package:basic_game/helpers/enums.dart';
import 'package:basic_game/helpers/game_state_builder.dart';
import 'package:basic_game/models/tile_state_model.dart';

class GameEngine {
  late Map<int, TileStateModel> _currentGameState;
  late Map<int, TileStateModel> _newGameState;
  late List<dynamic> _gameBoard;
  late TileStateModel? _currentSelectedTile;
  late int _boardId;
  int _completedTiles = 0;
  late GameDifficulty _gameDifficulty;

  GameEngine() {
    print("game engine init!!! ----------");
  }

  // set the difficulty of the current game
  set setGameDifficulty(GameDifficulty difficulty) =>
      _gameDifficulty = difficulty;

  // get the difficulty of the current game
  GameDifficulty get getGameDifficulty => _gameDifficulty;

  // update a tile in the current game state and set it as the new state
  //  TODO: refactor to handle mode changes
  set updateTileInGameState(TileStateModel updatedTile) {
    _newGameState.update(updatedTile.id, (value) => updatedTile);
    _currentGameState = _newGameState;
  }

  // get the new game state
  Map<int, TileStateModel> get getNewGameState => _newGameState;

  // initialize game
  void initializeGame({
    required List<dynamic> gameBoardData,
    required GameDifficulty difficulty,
  }) {
    _gameBoard = gameBoardData;
    _gameDifficulty = difficulty;
    _completedTiles = getNumberOfCompletedTiles(difficulty);
    _newGameState = buildTileStateMap(
      gameBoard: _gameBoard,
      numberOfCompletedTiles: _completedTiles,
    );
    _currentSelectedTile = null;
  }

  // Map<int, TileStateModel> updateTileStates(TileStateModel updatedTileState) {
  //   if (_currentSelectedTile == null) {
  //     _currentSelectedTile = updatedTileState;
  //     _currentGameState = _newGameState;
  //   } else if (_currentSelectedTile?.id == updatedTileState.id) {
  //     _currentSelectedTile = null;
  //     // handle tiles have same id
  //   } else {}
  // }

  Map<int, TileStateModel> updateCompletedTiles(TileStateModel updatedTile) {
    //TileMode currentMode;
    int currentValue = updatedTile.value;

    if (_currentSelectedTile == null) {
      // set the current state, highlight all the tiles with the same value
      _currentSelectedTile = updatedTile;
      _newGameState = _updateTileState(
          currentMappedState: _newGameState,
          newMode: TileMode.highlighted,
          currentMode: TileMode.complete,
          tileValue: currentValue);
    } else if (_currentSelectedTile?.id == updatedTile.id) {
      // set the currentSelected to null, change highlighted to complete
      removeHighlights(_newGameState, false);
      currentValue = _currentSelectedTile!.value;
      _newGameState = _updateTileState(
          currentMappedState: _newGameState,
          newMode: TileMode.complete,
          currentMode: TileMode.highlighted,
          tileValue: currentValue);
      _currentSelectedTile = null;
    } else {
      // change all of the current highlighted to complete
      currentValue = _currentSelectedTile!.value;
      removeHighlights(_newGameState, false);
      _newGameState = _updateTileState(
          currentMappedState: _newGameState,
          newMode: TileMode.complete,
          currentMode: TileMode.highlighted,
          tileValue: currentValue);
      // set the currentSelected to the new update
      _currentSelectedTile = updatedTile;
      // change the current complete w matching value to highlighted
      currentValue = updatedTile.value;
      _newGameState = _updateTileState(
          currentMappedState: _newGameState,
          newMode: TileMode.highlighted,
          currentMode: TileMode.complete,
          tileValue: currentValue);
    }

    // switch (updatedTile){
    //   case
    // }
    return _newGameState;
  }

  Map<int, TileStateModel> updateNonCompletedTile(
      {required TileStateModel updatedTile}) {
    if (_currentSelectedTile == null) {
      _currentSelectedTile = updatedTile;
      _newGameState.update(
          updatedTile.id,
          (value) => TileStateModel(
              id: updatedTile.id,
              value: updatedTile.value,
              mode: TileMode.selected));
    } else if (_currentSelectedTile!.id != updatedTile.id) {
      removeHighlights(_newGameState, true);
      _newGameState.update(
          _currentSelectedTile!.id,
          (value) => TileStateModel(
              id: _currentSelectedTile!.id,
              value: _currentSelectedTile!.value,
              mode: TileMode.blank));
      _newGameState.update(
          updatedTile.id,
          (value) => TileStateModel(
              id: updatedTile.id,
              value: updatedTile.value,
              mode: TileMode.selected));
      _currentSelectedTile = updatedTile;
    } else {
      removeHighlights(_newGameState, true);
      _newGameState.update(
          _currentSelectedTile!.id,
          (value) => TileStateModel(
              id: updatedTile.id,
              value: updatedTile.value,
              mode: TileMode.blank));
      _currentSelectedTile = null;
    }

    return _newGameState;
  }
}

Map<int, TileStateModel> _updateTileState(
    {required Map<int, TileStateModel> currentMappedState,
    required TileMode newMode,
    required TileMode currentMode,
    required int tileValue}) {
  currentMappedState.forEach((key, value) {
    if (value.mode == currentMode && value.value == tileValue) {
      currentMappedState.update(
          key,
          (value) =>
              TileStateModel(id: value.id, value: value.value, mode: newMode));
    }
  });
  return currentMappedState;
}

Map<int, TileStateModel> removeHighlights(
    Map<int, TileStateModel> gameState, bool complete) {
  Map<int, TileStateModel> tempMap = gameState;
  if (complete) {
    tempMap.forEach((key, value) {
      if (value.mode == TileMode.highlighted) {
        tempMap.update(
            key,
            (value) => TileStateModel(
                id: value.id, value: value.value, mode: TileMode.complete));
      }
    });
  } else {
    tempMap.forEach((key, value) {
      if (value.mode == TileMode.selected) {
        tempMap.update(
            key,
            (value) => TileStateModel(
                id: value.id, value: value.value, mode: TileMode.blank));
      }
    });
  }
  return tempMap;
}
