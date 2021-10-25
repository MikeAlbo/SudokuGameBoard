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
    _boardDataApi.initJSONDataFromAssets();
    //final data = await _boardDataApi.getGameBoardById(id: 2);
  }

  Future<List<List>> getRandomBoard() {
    Random random = Random();
    int? length = _boardDataApi.getLength;
    int id = random.nextInt(length ?? 5);
    print("id: $id");
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
