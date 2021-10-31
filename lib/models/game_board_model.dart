class GameBoardModel {
  final int boardId;
  final List<List<int>> gameBoard;

  GameBoardModel.fromJSON(Map<String, dynamic> parsedJSON)
      : boardId = parsedJSON["board_id"],
        gameBoard = parsedJSON["game_board"];
}
