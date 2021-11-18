import 'package:basic_game/app/widgets/gameBoardScreen/GameControlBar/game_control_bar.dart';
import 'package:basic_game/app/widgets/gameBoardScreen/appBar/app_bar.dart';
import 'package:basic_game/app/widgets/gameBoardScreen/gameStateDisplay/game_state_display.dart';
import 'package:basic_game/app/widgets/gameBoardScreen/number_row_selector.dart';
import 'package:basic_game/app/widgets/game_board.dart';
import 'package:basic_game/bloc/gameBoard/game_board_provider.dart';
import 'package:flutter/material.dart';

class GameBoardScreen extends StatefulWidget {
  const GameBoardScreen({Key? key}) : super(key: key);

  @override
  State<GameBoardScreen> createState() => _GameBoardScreenState();
}

class _GameBoardScreenState extends State<GameBoardScreen> {
  @override
  Widget build(BuildContext context) {
    print("screen built");
    GameBoardBloc _gameBoardBloc = GameBoardProvider.of(context);
    //_gameBoardBloc.selectDifficulty(GameDifficulty.medium);
    // _gameBoardBloc.setupNewGame(difficulty: GameDifficulty.easy);
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
    bool isFullScreen = false; // todo: should be set by gameBloc
    double standardSizeAdjustment = 0.90;
    double fullScreenSizeSizeAdjustment = 0.95;
    _gameBoardBloc.createNewGame(); //  TODO: should be called on route change

    double _getAspectSize(double size, bool isFullScreen) {
      double adjustmentValue =
          isFullScreen ? fullScreenSizeSizeAdjustment : standardSizeAdjustment;
      return size * adjustmentValue;
    }

    return Scaffold(
      appBar: buildGameBoardScreenAppBar(bloc: _gameBoardBloc, title: "Sudoku"),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment:
          //     CrossAxisAlignment.stretch, //  TODO: use for full screen
          children: [
            GameStateDisplay(
              gameDifficulty: _gameBoardBloc.getCurrentGameDifficulty,
              createNewGame: _gameBoardBloc.createNewGame,
            ),
            FutureBuilder(
              future: _gameBoardBloc.generateNewRandomGame(context),
              builder: (BuildContext context,
                      AsyncSnapshot<List<TableRow>> snapshot) =>
                  snapshot.hasData
                      ? buildGameBoard(
                          tableWidth: _getAspectSize(screenWidth, isFullScreen),
                          tableHeight:
                              _getAspectSize(screenHeight, isFullScreen),
                          isFullScreen: isFullScreen,
                          child: snapshot.data!)
                      : const Center(
                          child: Text("yeah"),
                        ),
            ),
            GameControlBar(),
            const NumberRowSelector(),
          ],
        ),
      ),
    );
  }
}

//  TODO: add widget to represent appBar
//  TODO: add widget to represent
