// tile helpers

// todo: container animation should be considered and applied based on action
// todo: visual, button like animations ->  related to above
// todo: consider abstracting the tile container into its own file/ stateful widget, maybe the rest of the tile could be stateless
// todo: layout mode for single number
// todo: layout mode for grid, used for notes mode

import 'package:basic_game/Themes/tile_decoration_themes.dart';
import 'package:flutter/material.dart';

/// TileMode is  used to identify or modify the state of the Tile.
enum TileMode {
  blank, // a blank tile in a neutral state
  active, // a tile that is actively selected but not completed
  completed, // a tile that is numbered, no longer selectable -- when in this mode, no other mode can be applied --
  selected, // visual/ haptic feedback that a tile has been tapped, pressed, or drag event
  highlighted, // visual cue for user when like numbers/ row / column are selected
  error, // incorrect input feedback for user, both haptic and visual
  correct, // correct input feedback for user when input matches value
  notes, // notes mode, will change layout of tile to support grid of notes
}

/// Tile selection helper
///
/// select the correct tile mode based on rules
TileMode selectTileMode(
    {required TileMode currentMode, required TileMode newMode}) {
  //  TODO: if tile mode is complete, can only be updated to highlighted, and back
  //  TODO: if tile is blank, can use other modes except highlighted
  //  TODO: can only go from correct to complete
  TileMode updatedMode = currentMode;

  switch (currentMode) {
    case TileMode.completed:
      {
        updatedMode = TileMode.highlighted;
        break;
      }
    case TileMode.correct:
      {
        updatedMode = TileMode.completed;
        break;
      }
    case TileMode.highlighted:
      {
        updatedMode = TileMode.completed;
        break;
      }
    case TileMode.error:
      {
        updatedMode = TileMode.blank;
        break;
      }
    case TileMode.notes:
      {
        updatedMode = TileMode.blank;
        break;
      }
    case TileMode.active:
      {
        switch (newMode) {
          case TileMode.correct:
            {
              updatedMode = TileMode.completed;
              break;
            }
          case TileMode.blank:
            {
              updatedMode = TileMode.blank;
              break;
            }
          case TileMode.active:
            updatedMode = TileMode.active;
            break;
          case TileMode.completed:
            updatedMode = TileMode.active;
            break;
          case TileMode.highlighted:
            updatedMode = TileMode.active;
            break;
          case TileMode.error:
            updatedMode = TileMode.active;
            break;
          case TileMode.notes:
            updatedMode = TileMode.active;
            break;
          case TileMode.selected:
            updatedMode = updatedMode;
            break;
        }
        break;
      }
    case TileMode.blank:
      {
        switch (newMode) {
          case TileMode.blank:
            updatedMode = TileMode.blank;
            break;
          case TileMode.active:
            updatedMode = TileMode.blank;
            break;
          case TileMode.completed:
            updatedMode = TileMode.blank;
            break;
          case TileMode.highlighted:
            updatedMode = TileMode.blank;
            break;
          case TileMode.error:
            updatedMode = TileMode.blank;
            break;
          case TileMode.correct:
            updatedMode = TileMode.blank;
            break;
          case TileMode.notes:
            updatedMode = TileMode.notes;
            break;
          case TileMode.selected:
            updatedMode = updatedMode;
            break;
        }
        break;
      }
    case TileMode.selected:
      updatedMode = updatedMode;
      break;
  }

  return updatedMode;
}

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
