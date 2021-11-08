import 'package:basic_game/Themes/tile_decoration_themes.dart';
import 'package:basic_game/bloc/gameBoard/game_board_provider.dart';
import 'package:basic_game/helpers/enums.dart';
import 'package:basic_game/models/tile_state_model.dart';
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
      const Duration(milliseconds: 100); // duration of animation
  String tileText = ""; // the text displayed inside the tile
  bool tileCompleted = false; // tile completed (is visible) var
  bool tileSelected = false; // tile is selected
  late Color tileColor; // tile color
  bool animationComplete = true; // tile animation bool
  TileMode tileMode = TileMode.blank; // current tile mode
  void setTileToComplete() =>
      tileCompleted = true; // set child completed function

  @override
  void initState() {
    super.initState();
    tileColor = widget.initAsVisible
        ? widget.tileDecorationParams.completed
        : widget.tileDecorationParams.blankInactive;

    tileCompleted = widget.initAsVisible;
    //tileText = widget.initAsVisible ? widget.value.toString() : "";

    tileMode = widget.initAsVisible ? TileMode.complete : TileMode.blank;
  }

  void handleInputFromStream({required Map<int, TileStateModel> response}) {
    TileStateModel tileTsm = response[widget.id]!;
    print(
        "handle input --> ${tileTsm.id} --> ${tileTsm.mode} --> current mode: $tileMode");
    tileMode = tileTsm.mode;
    tileColor = tileMode == TileMode.selected ? Colors.yellow : Colors.white;
  }

  void updateState({required Color color, required bool setToComplete}) {
    setState(() {
      tileColor = color;
      if (setToComplete) {
        setTileToComplete();
      }
    });
  }

  void onTileCLick(GameBoardBloc bloc) {
    TileStateModel tsm =
        TileStateModel(id: widget.id, value: widget.value, mode: tileMode);
    bloc.submitTileStateChange(tsm);
  }

  @override
  Widget build(BuildContext context) {
    // access to gameBoard bloc
    GameBoardBloc gameBoardBloc = GameBoardProvider.of(context);
    return GestureDetector(
      onTap: () => onTileCLick(gameBoardBloc), //handleOnTap(gameBoardBloc),
      child: StreamBuilder(
        stream: gameBoardBloc.tileListener,
        builder: (BuildContext context,
            AsyncSnapshot<Map<int, TileStateModel>> snapshot) {
          if (snapshot.hasData &&
              snapshot.requireData[widget.id]?.mode != tileMode) {
            handleInputFromStream(response: snapshot.requireData);
            //clearHighlights();
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

void _handleOnTap(GameBoardBloc bloc) {
  //  TODO: if tile blank, send message to highlight tile
  //  TODO: if tile complete, send message to highlight all tiles with same number
  //  TODO: if
}
