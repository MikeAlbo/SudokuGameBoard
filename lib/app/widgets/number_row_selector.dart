import 'package:basic_game/bloc/gameBoard/game_board_bloc.dart';
import 'package:basic_game/bloc/gameBoard/game_board_provider.dart';
import 'package:basic_game/models/input_value_model.dart';
import 'package:flutter/material.dart';

class NumberRowSelector extends StatelessWidget {
  const NumberRowSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameBoardBloc gameBoardBloc = GameBoardProvider.of(context);
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buildNumbers(gameBoardBloc),
      ),
    );
  }
}

List<GestureDetector> buildNumbers(GameBoardBloc gameBoardBloc) {
  List<GestureDetector> list = [];
  for (var i = 1; i <= 9; i++) {
    list.add(numberBuilder(gameBoardBloc: gameBoardBloc, number: i));
  }
  return list;
}

//  TODO: should convert to stfl widget to handle color change of tile and vis of number
GestureDetector numberBuilder(
    {required GameBoardBloc gameBoardBloc, required int number}) {
  return GestureDetector(
    onTap: () =>
        gameBoardBloc.addSelectedNumber(InputValueModel(id: 1, value: number)),
    child: Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          color: Colors.blueGrey.shade100),
      child: Center(
        child: Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 50,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}
