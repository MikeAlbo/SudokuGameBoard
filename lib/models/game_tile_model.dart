import 'package:basic_game/helpers/enums.dart';

class GameTileModel {
  final int id;
  final int tileValue;
  final TileMode tileMode;

  GameTileModel(
      {required this.id, required this.tileValue, required this.tileMode});
}
