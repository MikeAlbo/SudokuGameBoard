class TileAnswerResponseModel {
  final int tileId;
  final bool correctResponse;
  final int tileValue;

  TileAnswerResponseModel(
      {required this.tileId,
      required this.correctResponse,
      required this.tileValue});
}
