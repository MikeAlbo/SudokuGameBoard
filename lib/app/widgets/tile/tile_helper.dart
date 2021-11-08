// tile helpers

// todo: container animation should be considered and applied based on action
// todo: visual, button like animations ->  related to above
// todo: consider abstracting the tile container into its own file/ stateful widget, maybe the rest of the tile could be stateless
// todo: layout mode for single number
// todo: layout mode for grid, used for notes mode

import 'package:basic_game/Themes/tile_decoration_themes.dart';
import 'package:flutter/material.dart';

//  TODO: remove
// enum TileResponse {
//   selected, // when a user selects a tile
//   correct, // user input was correct
//   incorrect, // user input was incorrect
//   highlighted, // user selected a complete tile, tile should be highlighted
//   notes, // notes mode
// }

//  TODO: will probably need to separate out the enums into two, response, and tileState
//  TODO: responses will

/// TileBorderGenerator
///
/// TileBorderGenerator takes in the id [1,2,3,etc.] of the tile and provides
/// the correct border for the tile in regards of the tile's position on the
/// board
///
Border tileBorderGenerator(
    {required int tileId, required TileDecorationParams tdp}) {
  /// function setup
  ///
  /// column -- defines which column the tile lies in from 1-9;
  /// row --  defines which row the column lies in from 1 - 9;
  /// right -- determines if the tile is in column 3 or 6;
  /// bottom -- determines if the tiles lies in row 3 or 6;
  /// the border is build with a default style which is updated if a tile falls
  /// in either a column or row 3 or 6;

  //define column and row of tile
  int column = tileId % 9;
  int row = (tileId / 9).ceil();

  //determine if tile needs a modified border
  bool right = column == 3 || column == 6 ? true : false;
  bool left = column == 4 || column == 7 ? true : false;
  bool bottom = row == 3 || row == 6 ? true : false;
  bool top = row == 4 || row == 7 ? true : false;

  // builds a Border widget that takes in a default style, modifies style
  // if tile lies in a border position
  Border border = Border(
    top: top
        ? tdp.borderSide
            .copyWith(width: tdp.gridBorderWidth, color: tdp.gridBorderColor)
        : tdp.borderSide,
    left: left
        ? tdp.borderSide
            .copyWith(width: tdp.gridBorderWidth, color: tdp.gridBorderColor)
        : tdp.borderSide,
    bottom: bottom
        ? tdp.borderSide
            .copyWith(width: tdp.gridBorderWidth, color: tdp.gridBorderColor)
        : tdp.borderSide,
    right: right
        ? tdp.borderSide
            .copyWith(width: tdp.gridBorderWidth, color: tdp.gridBorderColor)
        : tdp.borderSide,
  );

  return border;
}
