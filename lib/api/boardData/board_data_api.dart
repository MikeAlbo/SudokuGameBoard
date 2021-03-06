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

// main class definition
class BoardDataApi {
  final String dataSetName; // the name of the dataset being retrieved
  String rootFolder; // root folder for local assets

  BoardDataApi({required this.dataSetName, this.rootFolder = "assets"});

  // init setup of data from a local folder, defaults to "assets"
  Future<String> _getAssetFromFile() async {
    return await rootBundle.loadString(
        "$rootFolder/$dataSetName"); //  TODO: handle loadString errors
  }

  Future<List<dynamic>> getJSONData() async {
    return jsonDecode(
        await _getAssetFromFile()); //  TODO: handleJSON decode error
  }

  // get  game board by ID
  // Future<List<List>> getGameBoardById({required int id}) async {
  //   return await initJSONDataFromLocalStorage().then((value) {
  //     List<dynamic> mapped = Map<String, dynamic>.from(value[id]).values.first;
  //     print(mapped.cast<List>());
  //     return mapped.cast<List>();
  //   });
  // }
}

//  TODO: consider making a data model for the Board Data
