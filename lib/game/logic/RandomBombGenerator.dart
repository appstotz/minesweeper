import 'dart:math';


/// a Class to generate a random field for the bombs
class RandomBombGenerator{

  /// generate a new field
  List<bool> generateNewField(int width, int height, int bombCount){
    if(width <= 0){
      throw ArgumentError.value(width);
    }
    if(height <= 0){
      throw ArgumentError.value(height);
    }
    if(bombCount <= 0){
      throw ArgumentError.value(bombCount);
    }
    if((width * height) <= bombCount){
      throw ArgumentError("bomb count to high");
    }
    final random = Random();
    //  reduce 1 because causing the player to tap on a bomb at the beginning is no fun
    final neededFields = (width * height) - 1;
    final List<bool> list = List.generate(neededFields, (index) => random.nextBool());
    return list;
  }

}