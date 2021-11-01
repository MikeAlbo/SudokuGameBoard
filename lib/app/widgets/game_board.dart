import 'package:flutter/material.dart';

/// Game Board Layout
///
/// Returns a container that contains the game board tiles.
///
Container buildGameBoard(
    {required double tableWidth,
    required double tableHeight,
    required List<TableRow> child}) {
  return Container(
      width: tableWidth,
      height: tableHeight,
      margin: const EdgeInsets.all(
          10), //  TODO:maybe need to convert to dynamic value
      child: FittedBox(
          child: Table(
        defaultColumnWidth: FixedColumnWidth(tableWidth / 9),
        border: TableBorder.symmetric(
          outside: const BorderSide(
            color: Colors.black,
            width: 5,
          ),
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: child,
      )));
}
