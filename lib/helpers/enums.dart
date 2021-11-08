enum GameDifficulty { easy, medium, hard, advanced }

/// TileMode is  used to identify or modify the state of the Tile.
enum TileMode {
  blank, // a blank tile in a neutral state
  complete, // a tile that is not selected but complete
  error, // a tile that has received an incorrect response--
  highlighted, // a tile that is complete, and tile number has been selected
}
