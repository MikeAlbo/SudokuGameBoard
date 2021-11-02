import 'package:basic_game/Themes/tile_decoration_themes.dart';
import 'package:basic_game/bloc/gameBoard/game_board_provider.dart';
import 'package:basic_game/models/game_tile_model.dart';
import 'package:basic_game/models/tile_answer_response_model.dart';
import 'package:flutter/material.dart';

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

class _TileState extends State<Tile> with SingleTickerProviderStateMixin {
  Duration animationDuration =
      const Duration(milliseconds: 50); // duration of animation
  bool tileCompleted = false; // tile completed (is visible) var
  bool tileSelected = false; // tile is selected
  late Color tileColor; // tile color
  bool animationComplete = true; // tile animation bool
  TileMode tileMode = TileMode.blank; // current tile mode
  late int valueDisplayed; // value displayed on tile when incorrect / selected
  void setTileToComplete() =>
      tileCompleted = true; // set child completed function

  @override
  void initState() {
    super.initState();
    tileColor = widget.initAsVisible
        ? widget.tileDecorationParams.completed
        : widget.tileDecorationParams.blankInactive;

    tileCompleted = widget.initAsVisible;

    tileMode = widget.initAsVisible ? TileMode.completed : TileMode.blank;
  }

  void handleInputFromStream(
      {required TileAnswerResponseModel tileAnswerResponse}) {
    if (tileAnswerResponse.tileId == widget.id) {
      if (tileAnswerResponse.correctResponse) {
        setTileToComplete();
        tileColor = widget.tileDecorationParams.completed;
      } else {
        tileColor = widget.tileDecorationParams.error;
      }
      //setState(() {});
    } else if (tileAnswerResponse.tileValue == widget.value && tileCompleted) {
      tileColor = widget.tileDecorationParams.highlighted;
      //setState(() {});
    }
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
    setState(() {});
  }

  void handleOnTap(GameBoardBloc bloc) {
    if (!tileSelected && tileCompleted) {
      tileColor = widget.tileDecorationParams.highlighted;
    } else if (tileSelected && tileCompleted) {
      tileColor = widget.tileDecorationParams.completed;
    } else if (!tileSelected && !tileCompleted) {
      tileColor = widget.tileDecorationParams.selected;
      bloc.addSelectedTile(
          GameTileModel(id: widget.id, tileValue: widget.value));
    } else {
      tileColor = widget.tileDecorationParams.blankInactive;
    }

    tileSelected = !tileSelected;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // access to gameBoard bloc
    GameBoardBloc gameBoardBloc = GameBoardProvider.of(context);
    return GestureDetector(
      onTap: () => handleOnTap(gameBoardBloc),
      child: StreamBuilder(
        stream: gameBoardBloc.validAnswer,
        builder: (BuildContext context,
            AsyncSnapshot<TileAnswerResponseModel> snapshot) {
          if (snapshot.hasData) {
            handleInputFromStream(tileAnswerResponse: snapshot.requireData);
          }
          return AnimatedContainer(
            duration: animationDuration,
            color: tileColor,
            child: Container(
              //  TODO: on end animation, check to see if it needs to replay
              decoration: BoxDecoration(
                //color: tileColor,
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
        },
      ),
    );
  }
}
