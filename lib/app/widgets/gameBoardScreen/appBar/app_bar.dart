//  TODO: colors should be set by theme data
//  TODO: create callback to access settings page

import 'package:basic_game/bloc/gameBoard/game_board_bloc.dart';
import 'package:flutter/material.dart';

AppBar buildGameBoardScreenAppBar(
    {required GameBoardBloc bloc, required String title}) {
  return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black45),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black45,
            ),
            onPressed: () {},
          ),
        ),
      ]);
}
