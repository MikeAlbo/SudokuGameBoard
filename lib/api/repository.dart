import 'package:basic_game/api/boardData/board_data_api.dart';

/// Repository
///
/// The Repository act sas the main interface between the data APIs
/// including asset accessing, remote storage, and local storage
///

// initialize  API instances
final _boardDataApi = BoardDataApi(dataSetName: "twoTest.json");

// main class definition
class _Repository {
  // initialize items upon new Repository instance
  void init() async {}

  // return a game board from the BoardDataAPI
  Future<List<dynamic>> get getAllLocalGameBoards =>
      _boardDataApi.getJSONData();
  //  TODO: when SQLLite db ready, should store/ retrieve "played" boards

  // constructor
  _Repository() {
    init();
  }
}

// create an instance of the repository and provide a getter for it
_Repository _repository = _Repository();
_Repository get getRepository => _repository;
