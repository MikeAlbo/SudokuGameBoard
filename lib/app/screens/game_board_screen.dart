import 'dart:math';

import 'package:basic_game/api/repository.dart';
import 'package:basic_game/bloc/game/game_provider.dart';
import 'package:basic_game/bloc/gameBoard/game_board_provider.dart';
import 'package:basic_game/models/game_tile_model.dart';
import 'package:basic_game/models/input_value_model.dart';
import 'package:basic_game/models/tile_answer_response_model.dart';
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
        body: Center(
      child: Container(
        color: Colors.blue.shade100,
        width: 1000.0,
        height: 300.0,
        child: Center(
          child: Column(
            children: [
              const Text(
                "Game Board Screen",
                style: TextStyle(fontSize: 50.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () => _selectTile(_gameBoardBloc),
                      child: const Text(
                        "Select Tile",
                        style: TextStyle(fontSize: 30),
                      )),
                  TextButton(
                      onPressed: () => _selectNumber(_gameBoardBloc),
                      child: const Text(
                        "Select Number",
                        style: TextStyle(fontSize: 30),
                      )),
                  TextButton(
                      onPressed: () => _getNewBoard(),
                      child: const Text(
                        "Get New Board",
                        style: TextStyle(fontSize: 50, color: Colors.red),
                      )),
                ],
              ),
              StreamBuilder<Object>(
                  stream: _gameBoardBloc.validAnswer,
                  builder: (context, snapshot) {
                    TileAnswerResponseModel? _tile =
                        snapshot.data as TileAnswerResponseModel?;
                    return !snapshot.hasData
                        ? Text("nothing yet")
                        : Text(
                            "${_tile?.correctResponse}",
                            style: TextStyle(fontSize: 50),
                          );
                  }),
            ],
          ),
        ),
      ),
    ));
  }
}

//  TODO: remove placeholder widget
//  TODO: add widget to represent game board
//  TODO: add widget to represent appBar
