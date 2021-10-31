String buildGameStateTable() {
  return ''' 
  CREATE TABLE GameState(
    id INTEGER PRIMARY KEY,
    lastUpdated INTEGER,
    currentGameState BLOB
  )
  ''';
}
