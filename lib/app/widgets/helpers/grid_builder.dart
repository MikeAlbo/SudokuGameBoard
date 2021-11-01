import 'dart:math';

import 'package:basic_game/Themes/tile_decoration_themes.dart';
import 'package:basic_game/app/widgets/tile/tile.dart';
import 'package:flutter/material.dart';

Random random = Random();

List<TableRow> gridBuilder(columns, rows, context) {
  // todo: this should be init globally or at least outside of this function
  TileDecorationParams tileDecorationParams = TileDecorationParams();
  Size ctxSize = MediaQuery.of(context).size;
  double tileWidth = ctxSize.width / 15;
  double tileHeight = ctxSize.height / 15;
  // todo: try and boxFit the tile into the container vs manipulating size params
  int mockId = 0; // mock tile id
  List<TableRow> gridOfRows = [];
  for (var r = 0; r < rows; r++) {
    List<Tile> rowValues = [];
    for (var c = 0; c < columns; c++) {
      mockId++;
      rowValues.add(Tile(
          tileDecorationParams: tileDecorationParams,
          tileWidth: tileWidth,
          tileHeight: tileHeight,
          value: random.nextInt(9),
          id: mockId,
          initAsVisible: random.nextInt(10).isEven,
          location: [r, c, r + c]));
      if (rowValues.length == columns) {
        TableRow tableRow = TableRow(children: rowValues);
        gridOfRows.add(tableRow);
      }
    }
  }
  return gridOfRows;
}
