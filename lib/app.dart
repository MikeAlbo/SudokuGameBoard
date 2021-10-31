import 'package:basic_game/bloc/gameBoard/game_board_provider.dart';
import 'package:flutter/material.dart';

import 'app/routes.dart';
import 'bloc/game/game_provider.dart';

class GameBoardApp extends StatelessWidget {
  const GameBoardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameProvider(
      child: GameBoardProvider(
        child: const MaterialApp(
          title: "Basic Sudoku GameBoard App",
          initialRoute: "/",
          onGenerateRoute: _routes,
        ),
      ),
    );
  }
}

Route _routes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case "/":
      return getGameBoardScreen(settings: routeSettings);
      break;
    default:
      return getGameBoardScreen(settings: routeSettings);
  }
}
