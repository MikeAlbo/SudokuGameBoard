class TileAnswerResponseModel {
  final int tileId;
  final bool correctResponse;
  final int tileValue;
  //final TileResponse tileResponse;

  TileAnswerResponseModel({
    required this.tileId,
    required this.correctResponse,
    required this.tileValue,
    //required this.tileResponse,
  });
}
