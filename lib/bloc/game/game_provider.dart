import 'package:flutter/material.dart'
    show InheritedWidget, Widget, Key, BuildContext;

import 'game_bloc.dart';

export 'game_bloc.dart';

class GameProvider extends InheritedWidget {
  final GameBloc _gameBloc;

  GameProvider({
    Key? key,
    required Widget child,
  })  : _gameBloc = GameBloc(),
        super(key: key, child: child);

  static GameBloc of(BuildContext context) {
    final GameProvider? result =
        context.dependOnInheritedWidgetOfExactType<GameProvider>();
    assert(result != null, 'No GameProvider found in context');
    return result!._gameBloc;
  }

  @override
  bool updateShouldNotify(GameProvider oldWidget) {
    return true;
  }
}
