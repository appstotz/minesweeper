import 'dart:math';

import 'package:minesweeper/game/logic/BoardGenerator.dart';
import 'package:test/test.dart';

void main() {
  group('test BoardGenerator', () {
    test('test random board generation', () async {
      final generator = BoardGenerator();
      final Random random = Random();
      var width = 5;
      var height = 4;
      final randomList = List.generate(
        width,
        (x) => List.generate(
          height,
          (index) => random.nextBool(),
        ),
      );
      final randomField = generator.generateField(randomList);
      for (var x = 0; x < width; x++) {
        for (var y = 0; y < height; y++) {
          expect(randomField[x][y].bomb, randomList[x][y]);
        }
      }
    });

    test('test empty board generation', () async {
      final generator = BoardGenerator();
      var width = 5;
      var height = 4;
      final list = List.generate(
        width,
        (x) => List.generate(
          height,
          (index) => false,
        ),
      );
      final fields = generator.generateField(list);
      for (var x = 0; x < width; x++) {
        for (var y = 0; y < height; y++) {
          var field = fields[x][y];
          expect(field.bomb, list[x][y]);
          expect(field.bomb, false);
          expect(field.totalBombs, 0);
        }
      }
    });

    test('test empty board generation', () async {
      final generator = BoardGenerator();
      var width = 5;
      var height = 4;
      var board = generator.generateEmptyField(width, height);
      board.forEach((column) {
        column.forEach((element) {
          expect(element.bomb, false);
          expect(element.flagged, false);
          expect(element.revealed, false);
          expect(element.totalBombs, 0);
        });
      });
    });

    test('test full board generation', () async {
      final generator = BoardGenerator();
      var width = 5;
      var height = 4;
      final list = List.generate(
        width,
        (x) => List.generate(
          height,
          (index) => true,
        ),
      );
      final fields = generator.generateField(list);
      for (var x = 0; x < width; x++) {
        for (var y = 0; y < height; y++) {
          var field = fields[x][y];
          expect(field.bomb, list[x][y]);
          expect(field.bomb, true);
          if (x == 0 || x == width - 1) {
            if (y == 0 || y == height - 1) {
              expect(field.totalBombs, 4);
            } else {
              expect(field.totalBombs, 6);
            }
          } else if (y == 0 || y == height - 1) {
            expect(field.totalBombs, 6);
          } else {
            expect(field.totalBombs, 9);
          }
        }
      }
    });
  });
}
