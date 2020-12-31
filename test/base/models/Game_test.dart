import 'package:minesweeper/base/models/Field.dart';
import 'package:minesweeper/base/models/Game.dart';
import 'package:test/test.dart';

void main() {
  group('test Game', () {
    test('test game state', () async {
      var bombHidden = Field(true, false, false, 2);
      var emptyHidden = Field(false, false, false, 2);
      var emptyRevealed = Field(false, true, false, 2);
      var bombRevealed = Field(true, true, false, 2);
      var bombFlagged = Field(true, false, true, 2);

      var boardPlaying = [
        [bombHidden, emptyHidden],
        [emptyRevealed, bombFlagged]
      ];
      var gamePlaying = Game(boardPlaying);
      expect(gamePlaying.gameState, GameState.running);
      expect(gamePlaying.bombCount, 2);
      expect(gamePlaying.flags, 1);

      var boardWin = [
        [bombHidden, bombHidden],
        [emptyRevealed, emptyRevealed]
      ];
      var gameWin = Game(boardWin);
      expect(gameWin.gameState, GameState.win);
      expect(gameWin.bombCount, 2);
      expect(gameWin.flags, 0);

      var boardLost = [
        [bombRevealed, bombHidden],
        [bombFlagged, emptyHidden]
      ];
      var gameLost = Game(boardLost);
      expect(gameLost.gameState, GameState.lost);
      expect(gameLost.bombCount, 3);
      expect(gameLost.flags, 1);
    });
  });
}
