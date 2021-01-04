import 'package:test/test.dart';
import 'package:minesweeper/game/logic/RandomBombGenerator.dart';

void main() {
  group('test RandomBombGenerator', () {
    test('test argument exceptions', () async {
      final generator = RandomBombGenerator();
      try {
        generator.generateNewField(0, 5, 5, 2, 2);
        throw Exception("failed to throw error");
      } catch (e) {
        expect(e, isA<ArgumentError>());
      }

      try {
        generator.generateNewField(5, 0, 5, 2, 2);
        throw Exception("failed to throw error");
      } catch (e) {
        expect(e, isA<ArgumentError>());
      }

      try {
        generator.generateNewField(5, 5, 0, 2, 2);
        throw Exception("failed to throw error");
      } catch (e) {
        expect(e, isA<ArgumentError>());
      }

      try {
        generator.generateNewField(5, 5, 30, 2, 2);
        throw Exception("failed to throw error");
      } catch (e) {
        expect(e, isA<ArgumentError>());
      }

      try {
        generator.generateNewField(5, 5, 10, -1, 2);
        throw Exception("failed to throw error");
      } catch (e) {
        expect(e, isA<ArgumentError>());
      }

      try {
        generator.generateNewField(5, 5, 10, 2, 8);
        throw Exception("failed to throw error");
      } catch (e) {
        expect(e, isA<ArgumentError>());
      }
    });

    test('test normal generation', () async {
      final generator = RandomBombGenerator();
      final width = 5;
      final height = 4;
      final bombs = 10;
      final startX = 2;
      final startY = 3;
      final fields =
          generator.generateNewField(width, height, bombs, startX, startY);
      expect(fields.length, width);
      expect(fields[startX][startY], false);
      var count = 0;
      fields.forEach((x) {
        expect(x.length, height);
        count += x.where((bomb) => bomb == true).length;
      });
      expect(count, bombs);
    });
  });
}
