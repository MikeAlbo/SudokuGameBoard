import 'dart:core';

import 'package:basic_game/api/repository.dart';
import 'package:basic_game/models/game_tile_model.dart';
import 'package:basic_game/models/input_value_model.dart';
import 'package:basic_game/models/tile_answer_response_model.dart';
import 'package:rxdart/rxdart.dart';

//  TODO: get a game board set
//  TODO: capture the input from a tile selection
//  TODO: capture the input from the available selected tiles
//  TODO: handle the DB logging of each game state
//  TODO: handle the error logging/ response
// maybe should capture both into an object with a function
// then send that object into the stream to be parsed.
class GameBoardBloc {
  final repo = getRepository;
  final _selectedTile = BehaviorSubject<GameTileModel>();
  final _selectedNumber = BehaviorSubject<InputValueModel>();
  final _validAnswer = BehaviorSubject<TileAnswerResponseModel>();

  // getter for listening for correct answer
  Stream<TileAnswerResponseModel> get validAnswer => _validAnswer.stream;

  // getter to add item to selectedTile
  Function(GameTileModel) get addSelectedTile => _selectedTile.sink.add;

  // getter to add item to selectedNumber sink
  Function(InputValueModel) get addSelectedNumber => _selectedNumber.sink.add;

  GameBoardBloc() {
    _selectedNumber
        .bufferCount(1)
        .transform(_compareTransform(_selectedTile))
        .pipe(_validAnswer);
  }

  dispose() {
    _selectedTile.close();
    _selectedNumber.close();
    _validAnswer.close();
  }
}

// compare transformer, will compare the input stream and the tile value stream
// and determine if the values match, then return a proper response on the
// listening stream used by the individual tiles
_compareTransform(Stream<GameTileModel> tile) {
  return WithLatestFromStreamTransformer.with1(tile.bufferCount(1),
      (List<InputValueModel> t, List<GameTileModel> s) {
    return TileAnswerResponseModel(
        tileId: s.single.id,
        tileValue: s.single.tileValue,
        correctResponse: t.single.value == s.single.tileValue);
  });
}

//  TODO: remove test functions in game board
//  TODO: create a stream that handles the generation of game boards
//  TODO: revise models to handle tile states
//  TODO: add functionality to select correct action
//  TODO: may need to refactor stream transformer to accept "selection" -> bypass the number selection
