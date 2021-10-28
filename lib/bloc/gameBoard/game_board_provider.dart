import 'package:flutter/material.dart'
    show InheritedWidget, Widget, Key, BuildContext;

import 'game_board_bloc.dart';

export 'game_board_bloc.dart';

class GameBoardProvider extends InheritedWidget {
  final GameBoardBloc _gameBoardBloc;

  GameBoardProvider({
    Key? key,
    required Widget child,
  })  : _gameBoardBloc = GameBoardBloc(),
        super(key: key, child: child);

  static GameBoardBloc of(BuildContext context) {
    final GameBoardProvider? result =
        context.dependOnInheritedWidgetOfExactType<GameBoardProvider>();
    assert(result != null, 'No GameBoardProvider found in context');
    return result!._gameBoardBloc;
  }

  @override
  bool updateShouldNotify(GameBoardProvider oldWidget) {
    return true;
  }
}
