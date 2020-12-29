import 'package:minesweeper/base/models/Field.dart';

/// a generator for the board
class BoardGenerator {
  /// generate a board with a list of set bombs
  List<List<Field>> generateField(List<List<bool>> bombField) {
    final int width = bombField.length;
    final int height = bombField[0].length;
    final list = List.generate(
      width,
      (x) => List.generate(
        height,
        (y) {
          final entry = _getFieldValues(bombField, width, height, x, y);
          final Field field = Field(entry.key, false, false, entry.value);
          return field;
        },
      ),
    );
    return list;
  }

  /// get the field values, whether there is a bomb and the number of surrounding bombs
  MapEntry<bool, int> _getFieldValues(
      List<List<bool>> bombField, int width, int height, int x, int y) {
    final bool hasBomb = bombField[x][y];
    final bool isTop = y == 0;
    final bool isStart = x == 0;
    final bool isBottom = y == height - 1;
    final bool isEnd = x == width - 1;
    int count = 0;
    if (hasBomb) {
      count++;
    }
    if (!isTop) {
      final top = y - 1;
      if (bombField[x][top]) {
        count++;
      }
      if (!isStart && bombField[x - 1][top]) {
        count++;
      }
      if (!isEnd && bombField[x + 1][top]) {
        count++;
      }
    }
    if (!isBottom) {
      final bottom = y + 1;
      if (bombField[x][bottom]) {
        count++;
      }
      if (!isStart && bombField[x - 1][bottom]) {
        count++;
      }
      if (!isEnd && bombField[x + 1][bottom]) {
        count++;
      }
    }
    if (!isStart && bombField[x - 1][y]) {
      count++;
    }
    if (!isEnd && bombField[x + 1][y]) {
      count++;
    }
    return MapEntry(hasBomb, count);
  }
}
