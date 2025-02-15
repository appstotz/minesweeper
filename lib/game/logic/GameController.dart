import 'package:minesweeper/base/models/Field.dart';
import 'package:minesweeper/base/models/Game.dart';
import 'package:minesweeper/game/logic/BoardGenerator.dart';
import 'package:minesweeper/game/logic/RandomBombGenerator.dart';
import 'package:rxdart/rxdart.dart';

/// the controller for the game
class GameController {
  /// the generator for a new board
  final BoardGenerator _boardGenerator = BoardGenerator();

  /// the generator for a new list of bombs
  final RandomBombGenerator _randomBombGenerator = RandomBombGenerator();

  /// the stream with the current game
  final BehaviorSubject<Game> gameSubject = BehaviorSubject();

  /// dismiss this controller
  void dismiss() {
    gameSubject.close();
  }

  /// the width for new boards
  int boardWidth = 10;

  /// the height for new boards
  int boardHeight = 10;

  /// the number of bombs for a new board
  int bombCount = 20;

  /// begin a new game with an empty field
  Future<void> beginNewGame() async {
    var board = _boardGenerator.generateEmptyField(boardWidth, boardHeight);
    var game = Game(board);
    gameSubject.add(game);
  }

  /// begin a new game with pushing any field
  void _beginNewGame(int x, int y) async {
    var bombs = _randomBombGenerator.generateNewField(
        boardWidth, boardHeight, bombCount, x, y);
    var newField = _boardGenerator.generateField(bombs);
    var game = Game(newField);
    _revealAround(game.board, x, y, startPosition: true);
    gameSubject.add(game);
  }

  /// reveal fields around the current one
  void _revealAround(
    List<List<Field>> fields,
    int x,
    int y, {
    bool byEmptyField = false,
    bool startPosition = false,
  }) {
    var myField = fields[x][y];
    if (myField.revealed) {
      return;
    }
    _setRevealed(fields, x, y);
    var top = y == 0;
    var start = x == 0;
    var bottom = y == fields.first.length - 1;
    var end = x == fields.length - 1;
    if (!top) {
      _checkReveal(fields, x, y - 1, byEmptyField, startPosition);
      if (!start) {
        _checkReveal(fields, x - 1, y - 1, byEmptyField, startPosition);
      }
      if (!end) {
        _checkReveal(fields, x + 1, y - 1, byEmptyField, startPosition);
      }
    }
    if (!bottom) {
      _checkReveal(fields, x, y + 1, byEmptyField, startPosition);
      if (!start) {
        _checkReveal(fields, x - 1, y + 1, byEmptyField, startPosition);
      }
      if (!end) {
        _checkReveal(fields, x + 1, y + 1, byEmptyField, startPosition);
      }
    }
    if (!start) {
      _checkReveal(fields, x - 1, y, byEmptyField, startPosition);
    }
    if (!end) {
      _checkReveal(fields, x + 1, y, byEmptyField, startPosition);
    }
  }

  /// check whether this field should be revealed
  void _checkReveal(
    List<List<Field>> fields,
    int x,
    int y,
    bool byEmptyField,
    bool startPosition,
  ) {
    if (fields[x][y].totalBombs == 0) {
      _revealAround(fields, x, y, byEmptyField: true);
    } else {
      if ((byEmptyField || startPosition) && !fields[x][y].bomb) {
        _setRevealed(fields, x, y);
      }
    }
  }

  /// set revealed for a specific field
  void _setRevealed(List<List<Field>> fields, x, y) {
    var myField = fields[x][y];
    fields[x][y] = myField.setRevealed(true);
  }

  /// set flagged of a specific field
  void flag(num x, num y) async {
    var column = gameSubject.value.board[x];
    var field = column[y];
    column[y] = field.setFlagged(!field.flagged);
    gameSubject.add(gameSubject.value);
  }

  /// reveal a specific field or begin a new game a new game
  Future<void> reveal(num x, num y) async {
    if (gameSubject.value.bombCount == 0) {
      _beginNewGame(x, y);
      return;
    }
    _revealAround(gameSubject.value.board, x, y);
    gameSubject.add(gameSubject.value);
  }
}
