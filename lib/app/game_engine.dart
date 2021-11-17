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

  //TileStateModel? get isTileSelected => _currentSelectedTile;

  bool readyForNumberCompare() {
    if (_currentSelectedTile == null ||
        _currentSelectedTile!.mode != TileMode.blank) {
      print("false! ${_currentSelectedTile!.mode}");
      return false;
    }
    return true;
  }

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
      removeHighlights(_newGameState, true);
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
      removeHighlights(_newGameState, true);
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
      _newGameState = removeHighlights(_newGameState, false);
      _newGameState.update(
          _currentSelectedTile!.id,
          (value) => TileStateModel(
              id: _currentSelectedTile!.id,
              value: _currentSelectedTile!.value,
              mode: _currentSelectedTile!.mode == TileMode.complete
                  ? TileMode.complete
                  : TileMode.blank));
      print("tile 1 first update: ${_newGameState[1]!.mode}");
      _newGameState.update(
          updatedTile.id,
          (value) => TileStateModel(
              id: updatedTile.id,
              value: updatedTile.value,
              mode: TileMode.selected));
      _currentSelectedTile = updatedTile;
      print("tile 1 last update: ${_newGameState[1]!.mode}");
    } else {
      _newGameState = removeHighlights(_newGameState, false);
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

  // handle comparison of tile and inout number
  Map<int, TileStateModel> testNumberAgainstTile({required int number}) {
    if (_currentSelectedTile != null) {
      if (_currentSelectedTile!.value == number) {
        _newGameState.update(
            _currentSelectedTile!.id,
            (value) => TileStateModel(
                id: _currentSelectedTile!.id,
                value: _currentSelectedTile!.value,
                mode: TileMode.complete));
        _currentSelectedTile = null;
      } else {
        _newGameState.update(
            _currentSelectedTile!.id,
            (value) => TileStateModel(
                id: _currentSelectedTile!.id,
                value: _currentSelectedTile!.value,
                mode: TileMode.error));
      }
    }

    return _newGameState;
  }
} // game engine

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
      if (value.mode == TileMode.selected) {
        tempMap.update(
            key,
            (value) => TileStateModel(
                id: value.id, value: value.value, mode: TileMode.blank));
      }
    });
  } else {
    tempMap.forEach((key, value) {
      if (value.mode == TileMode.highlighted) {
        tempMap.update(
            key,
            (value) => TileStateModel(
                id: value.id, value: value.value, mode: TileMode.complete));
      }
    });
  }
  return tempMap;
}
