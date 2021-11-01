import 'package:flutter/material.dart';

/// TileDecorationParams provides all of the available colors to the Tile class.
class TileDecorationParams {
  /// Tile background colors.
  final Color blankInactive = Colors.white;
  final Color blankActive = Colors.grey;
  final Color completed = Colors.grey.shade100;
  final Color correct = Colors.green.shade300;
  final Color selected = Colors.yellow;
  final Color highlighted = Colors.orange;
  final Color error = Colors.red;
  final Color notesInactive =
      Colors.white; //todo: possibly refactor to blank states
  final Color notesActive =
      Colors.white; //todo: possibly refactor to blank states

  /// Border colors and styling
  final Color gridBorderColor = Colors.grey.shade800;
  final Color standardBorderColor = Colors.black54;
  final double gridBorderWidth = 1;
  final double standardBorderWidth = 0.5;

  BorderSide get borderSide {
    return BorderSide(
      color: standardBorderColor,
      width: standardBorderWidth,
    );
  }

  Border get baseTileBorder {
    return Border.all(
      color: standardBorderColor,
      width: standardBorderWidth,
    );
  }

// BorderRadius get borderRadius {
//   return const BorderRadius.all(Radius.circular(5));
// }
}
