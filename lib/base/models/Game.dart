import 'Field.dart';

/// the game class for each game
class Game {
  /// the board of the game
  final List<List<Field>> board;

  /// count of the flags
  int get flags {
    var count = 0;
    board.forEach((column) {
      column.forEach((element) {
        if (element.flagged) {
          count++;
        }
      });
    });
    return count;
  }

  /// the count of all the bombs
  final int bombCount;

  /// get the state of the game
  GameState get gameState {
    var running = false;
    var flaggedBombs = 0;
    var flaggedWrongField = false;
    for (var column in board) {
      for (var value in column) {
        if(value.bomb) {
          if (value.revealed) {
            return GameState.lost;
          } else if(value.flagged) {
            flaggedBombs++;
          }
        } else {
          if (!value.revealed) {
            running = true;
          }
          if(value.flagged){
            flaggedWrongField = true;
          }
        }
      }
    }
    if(bombCount != 0 && !flaggedWrongField && flaggedBombs == bombCount){
      return GameState.win;
    }
    if (running) {
      return GameState.running;
    }
    return GameState.win;
  }

  /// the constructor, who also sets the count of the bombs
  Game(this.board)
      : bombCount = board.fold(
            0,
            (previousValue, element) =>
                previousValue +
                element
                    .where(
                      (element) => element.bomb,
                    )
                    .length);
}

/// the state of the game
enum GameState { running, win, lost }
