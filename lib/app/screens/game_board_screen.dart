import 'dart:math';

import 'package:basic_game/api/repository.dart';
import 'package:basic_game/app/widgets/game_board.dart';
import 'package:basic_game/app/widgets/helpers/grid_builder.dart';
import 'package:basic_game/bloc/game/game_provider.dart';
import 'package:basic_game/bloc/gameBoard/game_board_provider.dart';
import 'package:basic_game/models/game_tile_model.dart';
import 'package:basic_game/models/input_value_model.dart';
import 'package:flutter/material.dart';

class GameBoardScreen extends StatefulWidget {
  const GameBoardScreen({Key? key}) : super(key: key);

  @override
  State<GameBoardScreen> createState() => _GameBoardScreenState();
}

class _GameBoardScreenState extends State<GameBoardScreen> {
  final repo = getRepository;

  void _selectTile(GameBoardBloc gameBoardBloc) {
    int number = Random().nextInt(2);
    GameTileModel gameTileModel = GameTileModel(id: 1, tileValue: number);
    gameBoardBloc.addSelectedTile(gameTileModel);
    print("selectTile called: number => $number");
    setState(() {});
  }

  void _selectNumber(GameBoardBloc gameBoardBloc) {
    int number = Random().nextInt(2);
    InputValueModel inputValueModel = InputValueModel(id: 1, value: number);
    gameBoardBloc.addSelectedNumber(inputValueModel);
    print("selectNumber called: number => $number");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    GameBoardBloc _gameBoardBloc = GameBoardProvider.of(context);
    GameBloc gameBloc = GameProvider.of(context);

    void _getNewBoard() {
      gameBloc.getRandomGameBoard();
      setState(() {});
    }

    // _gameBoardBloc.validAnswer.last((TileAnswerResponseModel event) {
    //   print("valid Answer added to, event => ${event.correctResponse}");
    // });
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildGameBoard(
                tableWidth: 1000,
                tableHeight: 1000,
                child: gridBuilder(9, 9, context)),
          ],
        ),
      ),
    );
  }
}

//  TODO: remove placeholder widget
//  TODO: add widget to represent game board
//  TODO: add widget to represent appBar
