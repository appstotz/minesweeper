
import 'package:flutter/material.dart';
import 'package:minesweeper/base/models/Game.dart';
import 'package:minesweeper/game/widgets/FieldWidget.dart';

/// the widget for the board
class BoardWidget extends StatelessWidget {
  /// the current state of the game
  final Game game;

  /// the callback for the game
  final BoardWidgetCallBack callBack;

  const BoardWidget(this.game, this.callBack);

  @override
  Widget build(BuildContext context) {
    var width = game.board.length;
    var height = game.board.first.length;
    return GridView.builder(
      itemCount: width * height,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: height,
      ),
      itemBuilder: (BuildContext context, int index) {
        var y = index % width;
        final int x = index ~/ width;
        final field = game.board[x][y];
        final widget = FieldWidget(field);
        if (field.revealed) {
          return widget;
        }

        return GestureDetector(
          child: widget,
          onTap: () {
            if (!field.flagged) {
              callBack.reveal(x, y);
            }
          },
          onLongPress: () {
            callBack.flag(x, y);
          },
        );
      },
    );
  }
}

/// the callBack for this Widget
abstract class BoardWidgetCallBack{

  /// reveal a specific field
  void reveal(int x, int y);

  /// flag a specific field
  void flag(int x, int y);
}
