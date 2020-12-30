import 'Field.dart';

/// the game class for each game
class Game {
  /// the board of the game
  final List<List<Field>> board;

  /// get the state of the game
  GameState get gameState {
    var running = false;
    for (var column in board) {
      for (var value in column) {
        if (value.bomb && value.revealed) {
          return GameState.lost;
        }
        if (!value.bomb && !value.revealed) {
          running = true;
        }
      }
    }
    if(running){
      return GameState.running;
    }
    return GameState.win;
  }

  const Game(this.board);
}

/// the state of the game
enum GameState { running, win, lost }
