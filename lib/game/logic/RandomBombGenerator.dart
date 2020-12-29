import 'dart:math';

/// a Class to generate a random field for the bombs
class RandomBombGenerator {
  /// generate a new field
  /// generate a new playing field

  List<bool> _generateNewBombLocations(int width, int height, int bombCount) {
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
    final random = Random();
    //  reduce 1 because causing the player to tap on a bomb at the beginning is no fun
    final neededFields = (width * height) - 1;
    List<int> bombLocations = List.empty(growable: true);
    for (var i = 0; i < bombCount; i++) {
      int newRandom = random.nextInt(neededFields);
      while (true) {
        if (!bombLocations.contains(newRandom)) {
          break;
        }
        newRandom++;
        if (newRandom >= neededFields) {
          newRandom = 0;
        }
      }
      bombLocations.add(newRandom);
    }
    final List<bool> list =
        List.generate(neededFields, (index) => bombLocations.contains(index));
    return list;
  }

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
    final bombLocations = _generateNewBombLocations(width, height, bombCount);
    final addPosition = (firstClickX * height) + firstClickY;
    bombLocations.insert(addPosition, false);
    final generatedList = List.generate(
      width,
      (x) => List.generate(
        height,
        (y) => bombLocations[x * height + y],
      ),
    );
    return generatedList;
  }
}
