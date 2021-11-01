import 'package:basic_game/Themes/tile_decoration_themes.dart';
import 'package:basic_game/app/widgets/tile/tile_animation.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'tile_helper.dart';

BoxDecoration tileDecoration() {
  return BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(5)),
    border: Border.all(
      width: 1,
      color: Colors.black,
    ),
    color: Colors.white60,
  );
}

TextStyle tileTextDecoration() {
  return const TextStyle(fontSize: 30, color: Colors.black);
}

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
  // set child completed function
  void setTileToComplete() => tileCompleted = true;

  @override
  void initState() {
    super.initState();
    tileColor = widget.initAsVisible
        ? widget.tileDecorationParams.completed
        : widget.tileDecorationParams.blankInactive;

    tileCompleted = widget.initAsVisible;
  }

  void updateState({required Color color, required bool setToComplete}) {
    setState(() {
      tileColor = color;
      if (setToComplete) {
        setTileToComplete();
      }
    });
  }

  void handleOnTap() {
    // todo: this will eventually send the tile value to the stream to be
    //  evaluated, which will return how the correct tile mode to be used

    Tuple3<Color, int, bool> animationParams;

    animationParams = selectAnimation(
        tileCompleted ? TileMode.highlighted : TileMode.selected);
    updateState(
      color: animationParams.item1,
      setToComplete: animationParams.item3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handleOnTap(),
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
