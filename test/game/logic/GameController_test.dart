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
      controller.beginNewGame(startX, startY);

      var game = await controller.gameSubject.first.timeout(
        Duration(seconds: 10),
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
  });
}
