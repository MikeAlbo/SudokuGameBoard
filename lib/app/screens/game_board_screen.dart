import 'package:basic_game/app/widgets/game_board.dart';
import 'package:basic_game/app/widgets/helpers/grid_builder.dart';
import 'package:flutter/material.dart';

class GameBoardScreen extends StatefulWidget {
  const GameBoardScreen({Key? key}) : super(key: key);

  @override
  State<GameBoardScreen> createState() => _GameBoardScreenState();
}

class _GameBoardScreenState extends State<GameBoardScreen> {
  // void _selectTile(GameBoardBloc gameBoardBloc) {
  //   int number = Random().nextInt(2);
  //   GameTileModel gameTileModel = GameTileModel(id: 1, tileValue: number);
  //   gameBoardBloc.addSelectedTile(gameTileModel);
  //   print("selectTile called: number => $number");
  //   setState(() {});
  // }
  //
  // void _selectNumber(GameBoardBloc gameBoardBloc) {
  //   int number = Random().nextInt(2);
  //   InputValueModel inputValueModel = InputValueModel(id: 1, value: number);
  //   gameBoardBloc.addSelectedNumber(inputValueModel);
  //   print("selectNumber called: number => $number");
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    // GameBoardBloc _gameBoardBloc = GameBoardProvider.of(context);
    // GameBloc gameBloc = GameProvider.of(context);
    //
    // void _getNewBoard() {
    //   gameBloc.getRandomGameBoard();
    //   setState(() {});
    // }

    // _gameBoardBloc.validAnswer.last((TileAnswerResponseModel event) {
    //   print("valid Answer added to, event => ${event.correctResponse}");
    // });

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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildGameBoard(
                  tableWidth: _getAspectSize(screenWidth, isFullScreen),
                  tableHeight: _getAspectSize(screenHeight, isFullScreen),
                  isFullScreen: isFullScreen,
                  child: gridBuilder(9, 9, context)),
            ],
          ),
        ),
      ),
    );
  }
}

//  TODO: add widget to represent appBar
//  TODO: add widget to represent
