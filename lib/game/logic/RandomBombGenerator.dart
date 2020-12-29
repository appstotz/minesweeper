import 'dart:math';

/// a Class to generate a random field for the bombs
class RandomBombGenerator {
  /// generate a new list of random bomb locations
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
