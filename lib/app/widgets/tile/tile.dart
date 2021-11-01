import 'package:basic_game/Themes/tile_decoration_themes.dart';
import 'package:basic_game/app/widgets/tile/tile_animation.dart';
import 'package:basic_game/bloc/gameBoard/game_board_provider.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'tile_helper.dart';

TextStyle tileTextDecoration() {
  return const TextStyle(fontSize: 30, color: Colors.black);
} //  TODO: remove to theme widget

//  TODO: tile should i tile model over the stream when selected
//  TODO: tile should listen for it's id and response from bloc
//  TODO: tile should animate based on state of tile
//  TODO: animation bool / enum to determine state of animation

class Tile extends StatefulWidget {
  final TileDecorationParams tileDecorationParams;
  final double tileHeight;
  final double tileWidth;
  final int value;
  final int id;
  final List<int> location;
  final bool initAsVisible;
  const Tile(
      {Key? key,
      required this.tileDecorationParams,
      required this.tileHeight,
      required this.tileWidth,
      required this.value,
      required this.id,
      required this.initAsVisible,
      required this.location})
      : super(key: key);

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  // duration of animation
  int animationDuration = 50;
  // tile completed (is visible) var
  bool tileCompleted = false;
  // tile color
  Color tileColor = Colors.white;
  // tile animation bool
  bool animationComplete = true;
  // current tile mode
  TileMode tileMode = TileMode.blank;
  // set child completed function
  void setTileToComplete() => tileCompleted = true;

  @override
  void initState() {
    super.initState();
    tileColor = widget.initAsVisible
        ? widget.tileDecorationParams.completed
        : widget.tileDecorationParams.blankInactive;

    tileCompleted = widget.initAsVisible;

    tileMode = widget.initAsVisible ? TileMode.completed : TileMode.blank;
  }

  void updateState({required Color color, required bool setToComplete}) {
    setState(() {
      tileColor = color;
      if (setToComplete) {
        setTileToComplete();
      }
    });
  }

  void updateTileMode(
      {required TileMode currentTileMode, required TileMode newTileMode}) {
    setState(() {
      selectTileMode(currentMode: currentTileMode, newMode: newTileMode);
    });
  }

  void handleOnTap(GameBoardBloc bloc) {
    // todo: this will eventually send the tile value to the stream to be
    //  evaluated, which will return how the correct tile mode to be used

    Tuple3<Color, int, bool> animationParams;

    animationParams =
        selectAnimation(tileCompleted ? TileMode.highlighted : TileMode.active);
    updateState(
      color: animationParams.item1,
      setToComplete: animationParams.item3,
    );
  }

  @override
  Widget build(BuildContext context) {
    // access to gameBoard bloc
    GameBoardBloc gameBoardBloc = GameBoardProvider.of(context);
    return GestureDetector(
      onTap: () => handleOnTap(gameBoardBloc),
      child: AnimatedContainer(
        duration: Duration(milliseconds: animationDuration),
        decoration: BoxDecoration(
          color: tileColor,
          border: tileBorderGenerator(
            tileId: widget.id,
            tdp: widget.tileDecorationParams,
          ),
        ),
        width: widget.tileWidth,
        height: widget.tileHeight,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              tileCompleted ? widget.value.toString() : "",
              style: tileTextDecoration(),
            ),
          ),
        ),
      ),
    );
  }
}
