import 'package:minesweeper/game/logic/GameController.dart';
import 'package:test/test.dart';

void main() {
  group('test GameController', () {
    test('test game creation', () async {
      var startX = 2;
      var startY = 2;
      var controller = GameController();
      expect(controller.gameSubject.hasValue, false);
      controller.gameSubject.listen((value) {});
      await controller.beginNewGame();
      await controller.reveal(startX, startY);

      var game = await controller.gameSubject.last.timeout(
        Duration(milliseconds: 100),
      );

      var startField = game.board[startY][startY];
      expect(startField.revealed, true);
      expect(startField.bomb, false);

      var testSurrounding = (int x, int y) {
        var field = game.board[x][y];
        expect(field.revealed ^ field.bomb, true);
      };
      testSurrounding(startX - 1, startY - 1);
      testSurrounding(startX - 1, startY);
      testSurrounding(startX - 1, startY + 1);
      testSurrounding(startX, startY - 1);
      testSurrounding(startX, startY + 1);
      testSurrounding(startX + 1, startY - 1);
      testSurrounding(startX + 1, startY);
      testSurrounding(startX + 1, startY + 1);

      controller.dismiss();
    });

    test('test reveal', () async {
      var startX = 2;
      var startY = 2;
      var controller = GameController();
      expect(controller.gameSubject.hasValue, false);
      controller.gameSubject.listen((value) {});
      await controller.beginNewGame();
      await controller.reveal(startX, startY);

      var game = await controller.gameSubject.last.timeout(
        Duration(milliseconds: 100),
      );

      int foundY;
      int foundX = game.board.indexWhere((element) {
        var found =
            element.indexWhere((field) => !field.revealed && !field.bomb);
        if (found != -1) {
          foundY = found;
          return true;
        }
        return false;
      });

      expect(game.board[foundX][foundY].revealed, false);
      await controller.reveal(foundX, foundY);
      expectLater(
          await controller.gameSubject.stream
              .any((element) => element.board[foundX][foundY].revealed)
              .timeout(
                Duration(milliseconds: 100),
              ),
          true);

      controller.dismiss();
    });

    test('test new game', () async {
      var controller = GameController();
      expect(controller.gameSubject.hasValue, false);
      controller.gameSubject.listen((value) {});
      await controller.beginNewGame();

      var game = await controller.gameSubject.first.timeout(
        Duration(milliseconds: 100),
      );

      expect(game.bombCount, 0);
      game.board.forEach((column) {
        column.forEach((element) {
          expect(element.totalBombs, 0);
          expect(element.revealed, false);
          expect(element.flagged, false);
          expect(element.bomb, false);
        });
      });

      controller.dismiss();
    });

    test('test flag', () async {
      var startX = 2;
      var startY = 2;
      var controller = GameController();
      expect(controller.gameSubject.hasValue, false);
      controller.gameSubject.listen((value) {});
      await controller.beginNewGame();
      await controller.reveal(startX, startY);

      var game = await controller.gameSubject.last.timeout(
        Duration(milliseconds: 100),
      );

      int foundY;
      int foundX = game.board.indexWhere((element) {
        var found =
            element.indexWhere((field) => !field.revealed && !field.bomb);
        if (found != -1) {
          foundY = found;
          return true;
        }
        return false;
      });

      expect(game.board[foundX][foundY].revealed, false);
      controller.flag(foundX, foundY);
      expectLater(
          await controller.gameSubject.stream
              .any((element) => element.board[foundX][foundY].flagged)
              .timeout(
                Duration(seconds: 3),
              ),
          true);

      controller.dismiss();
    });
  });
}
