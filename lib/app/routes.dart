import 'package:basic_game/app/screens/game_board_screen.dart';
import 'package:flutter/material.dart';

///GameBoard Route
///
/// returns the route to the Game Board Screen
Route getGameBoardScreen({required RouteSettings settings}) {
  return MaterialPageRoute(builder: (BuildContext ctx) {
    return GameBoardScreen();
  });
}
