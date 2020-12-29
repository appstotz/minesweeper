import 'package:test/test.dart';
import 'package:minesweeper/game/logic/RandomBombGenerator.dart';

void main() {
  group('test RandomBombGenerator',() {
    test('test argument exceptions', () async {
      final generator = RandomBombGenerator();
      try {
        generator.generateNewField(0, 5, 5);
        throw Exception("failed to throw error");
      } catch (e) {
        expect(e, isA<ArgumentError>());
      }
      
      try {
        generator.generateNewField(5, 0, 5);
        throw Exception("failed to throw error");
      } catch (e) {
        expect(e, isA<ArgumentError>());
      }
      
      try {
        generator.generateNewField(5, 5, 0);
        throw Exception("failed to throw error");
      } catch (e) {
        expect(e, isA<ArgumentError>());
      }

      try {
        generator.generateNewField(5, 5, 30);
        throw Exception("failed to throw error");
      } catch (e) {
        expect(e, isA<ArgumentError>());
      }
    });
    
    test('test normal generation', () async {
      final generator = RandomBombGenerator();
      final width = 5;
      final height = 5;
      final bombs = 10;
      final fields = generator.generateNewField(width, height, bombs);
      expect(fields.length, (width * height) - 1);
      expect(fields.where((element) => element == true).length, bombs);
    });
  });
}
