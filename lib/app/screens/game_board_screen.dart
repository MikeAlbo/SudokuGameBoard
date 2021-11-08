import 'package:basic_game/app/widgets/game_board.dart';
import 'package:basic_game/app/widgets/helpers/grid_builder.dart';
import 'package:basic_game/app/widgets/number_row_selector.dart';
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
    GameBoardBloc _gameBoardBloc = GameBoardProvider.of(context);
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
    bool isFullScreen = false; // todo: should be set by gameBloc
    double standardSizeAdjustment = 0.90;
    double fullScreenSizeSizeAdjustment = 0.95;

    double _getAspectSize(double size, bool isFullScreen) {
      double adjustmentValue =
          isFullScreen ? fullScreenSizeSizeAdjustment : standardSizeAdjustment;
      return size * adjustmentValue;
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Sudoku",
      //     style: TextStyle(fontSize: 30, color: Colors.blueGrey),
      //   ),
      //   backgroundColor: Colors.white,
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment:
          //     CrossAxisAlignment.stretch, //  TODO: use for full screen
          children: [
            buildGameBoard(
                tableWidth: _getAspectSize(screenWidth, isFullScreen),
                tableHeight: _getAspectSize(screenHeight, isFullScreen),
                isFullScreen: isFullScreen,
                child: gridBuilder(9, 9, context)),
            const NumberRowSelector(),
          ],
        ),
      ),
    );
  }
}

//  TODO: add widget to represent appBar
//  TODO: add widget to represent
