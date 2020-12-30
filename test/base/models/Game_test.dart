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

      var boardPlaying = [
        [bombHidden, emptyHidden],
        [emptyRevealed, emptyHidden]
      ];
      var gamePlaying = Game(boardPlaying);
      expect(gamePlaying.gameState, GameState.running);

      var boardWin = [
        [bombHidden, bombHidden],
        [emptyRevealed, emptyRevealed]
      ];
      var gameWin = Game(boardWin);
      expect(gameWin.gameState, GameState.win);

      var boardLost = [
        [bombRevealed, bombHidden],
        [emptyRevealed, emptyHidden]
      ];
      var gameLost = Game(boardLost);
      expect(gameLost.gameState, GameState.lost);
    });
  });
}
