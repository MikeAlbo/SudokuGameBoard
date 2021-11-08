import 'dart:math';

import 'package:basic_game/Themes/tile_decoration_themes.dart';
import 'package:basic_game/app/widgets/tile/tile.dart';
import 'package:basic_game/helpers/enums.dart';
import 'package:basic_game/models/tile_state_model.dart';
import 'package:flutter/material.dart';

Random random = Random();

List<TableRow> newGridBuilder(
    {required BuildContext context,
    required Map<int, TileStateModel> mappedStates}) {
  TileDecorationParams tileDecorationParams = TileDecorationParams();
  Size ctxSize = MediaQuery.of(context).size;
  double tileWidth = ctxSize.width / 15;
  double tileHeight = ctxSize.height / 15;
  List<TableRow> gridOfRows = [];
  List<Tile> rowValues = [];
  mappedStates.forEach((key, value) {
    rowValues.add(Tile(
        tileDecorationParams: tileDecorationParams,
        tileHeight: tileHeight,
        tileWidth: tileWidth,
        value: value.value,
        id: value.id,
        initAsVisible: value.mode == TileMode.complete ? true : false,
        location: [1, 1, 1]));
    if (rowValues.length == 9) {
      gridOfRows.add(TableRow(children: rowValues.toList()));
      rowValues.clear();
    }
  });
  print("new grid complete");
  gridOfRows.forEach((element) {
    print(element);
  });

  return gridOfRows;
}

// List<TableRow> gridBuilder(
//     columns, rows, context, Map<int, TileStateModel> mapped) {
//   // _gridBuilder(context: context, mappedStates: mapped);
//   // todo: this should be init globally or at least outside of this function
//   TileDecorationParams tileDecorationParams = TileDecorationParams();
//   Size ctxSize = MediaQuery.of(context).size;
//   double tileWidth = ctxSize.width / 15;
//   double tileHeight = ctxSize.height / 15;
//   // todo: try and boxFit the tile into the container vs manipulating size params
//   int mockId = 0; // mock tile id
//   List<TableRow> gridOfRows = [];
//   for (var r = 0; r < rows; r++) {
//     List<Tile> rowValues = [];
//     for (var c = 0; c < columns; c++) {
//       mockId++;
//       rowValues.add(Tile(
//           tileDecorationParams: tileDecorationParams,
//           tileWidth: tileWidth,
//           tileHeight: tileHeight,
//           value: random.nextInt(9),
//           id: mockId,
//           initAsVisible: random.nextInt(10).isEven,
//           location: [r, c, r + c]));
//       if (rowValues.length == columns) {
//         TableRow tableRow = TableRow(children: rowValues);
//         //print(tableRow);
//         gridOfRows.add(tableRow);
//       }
//     }
//   }
//   return gridOfRows;
// }
