import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/services.dart';

/// BoardDataApi
///
/// BoardDataApi creates an interface between the repository and the
/// JSON data. V1 only allows access to data stored in the assets dir.
/// Future iterations should allow for http request (probably Firebase).
///

// completer setup
Completer _completer = Completer();
Future get ready => _completer.future;

// main class definition
class BoardDataApi {
  final String dataSetName; // the name of the dataset being retrieved
  String rootFolder; // root folder for local assets
  List<dynamic>? dataSet;

  BoardDataApi({required this.dataSetName, this.rootFolder = "assets"}) {}

  // init setup of data from assets folder
  Future initJSONDataFromAssets() async {
    String path = await rootBundle.loadString("$rootFolder/$dataSetName");
    dataSet = jsonDecode(path);
  }

  // get  game board by ID
  Future<List<List>> getGameBoardById({required int id}) async {
    if (dataSet == null) {
      print("reloading dataset from getGameBoard");
      await initJSONDataFromAssets();
    }
    List<dynamic> mapped = Map<String, dynamic>.from(dataSet?[id]).values.first;
    List<List> castedData = mapped.cast<List>();
    return castedData;
  }

  int? get getLength => dataSet?.length;
}
