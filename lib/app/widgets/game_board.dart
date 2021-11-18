import 'package:flutter/material.dart';

/// Game Board Layout
///
/// Returns a container that contains the game board tiles.
///
Container buildGameBoard({
  required double tableWidth,
  required double tableHeight,
  required bool isFullScreen,
  required List<TableRow> child,
}) {
  return Container(
      color: Colors.green,
      // width: tableWidth,
      // height: tableHeight,
      margin: const EdgeInsets.all(
          10), //  TODO:maybe need to convert to dynamic value
      child: FittedBox(
          child: Table(
        defaultColumnWidth:
            FixedColumnWidth(isFullScreen ? tableWidth / 10 : tableWidth / 9),
        border: TableBorder.symmetric(
          outside: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: child,
      )));
}

double _adjustColumnWidthForDisplaySize(
    {required bool isFullScreen, required double width}) {
  double adjustedWidth = isFullScreen ? 10 : 6;
  print("adjustedWidth: ${adjustedWidth * width}");
  return width / adjustedWidth;
}
