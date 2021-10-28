import 'dart:math';

import 'package:basic_game/api/boardData/board_data_api.dart';

/// Repository
///
/// The Repository act sas the main interface between the data APIs
/// including asset accessing, remote storage, and local storage
///

// initialize  API instances
final _boardDataApi = BoardDataApi(dataSetName: "fiveBoards.json");

// main class definition
class _Repository {
  // initialize items upon new Repository instance
  void init() async {
    getRandomBoard();
    //final data = await _boardDataApi.getGameBoardById(id: 2);
  }

  // Get a random game board
  //  TODO: get the length of the available dataset, use for nextInt limit
  //  TODO: when SQLLite db ready, should store/ retrieve "played" boards
  //  TODO: if id has been played, get new number. If all boards played, wipe table and start anew
  Future<List<List>> getRandomBoard() {
    int id = Random().nextInt(5);
    print("id: $id");
    return _boardDataApi.getGameBoardById(id: id);
  }

  // Get a board by specific ID
  Future<List<List>> getBoardById({required int id}) {
    return _boardDataApi.getGameBoardById(id: id);
  }

  // constructor
  _Repository() {
    init();
  }
}

// create an instance of the repository and provide a getter for it
_Repository _repository = _Repository();
_Repository get getRepository => _repository;
