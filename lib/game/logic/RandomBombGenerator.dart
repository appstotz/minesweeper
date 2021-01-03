import 'dart:math';

/// a Class to generate a random field for the bombs
class RandomBombGenerator {
  /// generate a new list of random bomb locations
  List<bool> _generateNewBombLocations(
    int width,
    int height,
    int bombCount,
    int firstClickX,
    int firstClickY,
  ) {
    if (width <= 0) {
      throw ArgumentError.value(width);
    }
    if (height <= 0) {
      throw ArgumentError.value(height);
    }
    if (bombCount <= 0) {
      throw ArgumentError.value(bombCount);
    }
    if ((width * height) <= bombCount) {
      throw ArgumentError("bomb count to high");
    }
    var reduceNeededFields = 9;
    if (firstClickX == 0 || firstClickX == width - 1) {
      if (firstClickY == 0 || firstClickY == height - 1) {
        reduceNeededFields = 4;
      } else {
        reduceNeededFields = 6;
      }
    } else if (firstClickY == 0 || firstClickY == height - 1) {
      reduceNeededFields = 6;
    }
    final random = Random();
    //  reduce 1 because causing the player to tap on a bomb at the beginning is no fun
    final neededFields = (width * height) - reduceNeededFields;
    final List<bool> list =
        List.generate(neededFields, (index) => index < bombCount);
    list.shuffle(random);
    return list;
  }

  /// generate a new playing field
  List<List<bool>> generateNewField(
    int width,
    int height,
    int bombCount,
    int firstClickX,
    int firstClickY,
  ) {
    if (firstClickY < 0 || firstClickY >= height) {
      throw ArgumentError.value(firstClickY);
    }
    if (firstClickX < 0 || firstClickX >= width) {
      throw ArgumentError.value(firstClickX);
    }
    final bombLocations = _generateNewBombLocations(
        width, height, bombCount, firstClickX, firstClickY);

    //  add the missing positions
    _addPositions(firstClickX, height, firstClickY, width, bombLocations);

    // generate  the list
    final generatedList = List.generate(
      width,
      (x) => List.generate(
        height,
        (y) => bombLocations[x * height + y],
      ),
    );
    return generatedList;
  }

  /// add the missing positions
  void _addPositions(int firstClickX, int height, int firstClickY, int width, List<bool> bombLocations) {
    var positions =
        List.of([(firstClickX * height) + firstClickY], growable: true);
    var top = firstClickY == 0;
    var start = firstClickX == 0;
    var bottom = firstClickY == height - 1;
    var end = firstClickX == width - 1;
    if (!top) {
      positions.add((firstClickX * height) + (firstClickY - 1));
      if (!start) {
        positions.add(((firstClickX - 1) * height) + (firstClickY - 1));
      }
      if (!end) {
        positions.add(((firstClickX + 1) * height) + (firstClickY - 1));
      }
    }
    if (!bottom) {
      positions.add((firstClickX * height) + (firstClickY + 1));
      if (!start) {
        positions.add(((firstClickX - 1) * height) + (firstClickY + 1));
      }
      if (!end) {
        positions.add(((firstClickX + 1) * height) + (firstClickY + 1));
      }
    }
    if (!start) {
      positions.add(((firstClickX - 1) * height) + firstClickY);
    }
    if (!end) {
      positions.add(((firstClickX + 1) * height) + firstClickY);
    }
    positions.sort((a, b) => a - b);
    positions.forEach((element) {
      bombLocations.insert(element, false);
    });
  }
}
