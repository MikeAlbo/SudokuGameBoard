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
    if (_currentSelectedTile?.id == updatedTile.id) {
      _newGameState = _currentGameState;
    }
    _newGameState.forEach((key, value) {
      if (value.value == updatedTile.value && value.mode == TileMode.complete) {
        _newGameState.update(
            key,
            (value) => TileStateModel(
                id: value.id, value: value.value, mode: TileMode.highlighted));
      }
    });

    _currentGameState = _newGameState;

    return _newGameState;
  }
}
