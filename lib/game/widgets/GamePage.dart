import 'package:flutter/material.dart';
import 'package:minesweeper/base/models/Game.dart';
import 'package:minesweeper/game/logic/GameController.dart';
import 'package:minesweeper/game/widgets/BoardWidget.dart';
import 'package:provider/provider.dart';

/// the page for the game
class GamePage extends StatelessWidget {
  const GamePage();

  /// the button to restart the game for the dialogs
  Widget _restartButton(BuildContext context, GameController gameController) {
    return RaisedButton(
      onPressed: () {
        gameController.beginNewGame(2, 2);
        Navigator.pop(context);
      },
      child: Text("restart"),
    );
  }

  /// show a dialog
  void _showDialog(BuildContext context, GameController gameController,
      String title, Key key) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          key: key,
          title: Text(
            title,
          ),
          actions: [
            _restartButton(context, gameController),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var gameController = Provider.of<GameController>(context);
    gameController.gameSubject.listen((game) {
      switch (game.gameState) {
        case GameState.running:
          return;
          break;
        case GameState.win:
          _showDialog(context, gameController, "You win", Key("winDialog"));
          break;
        case GameState.lost:
          _showDialog(context, gameController, "You lose", Key("loseDialog"));
          break;
      }
    });

    return StreamBuilder(
      stream: gameController.gameSubject,
      builder: (BuildContext context, AsyncSnapshot<Game> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Game"),
              actions: [
                _BoardHeaderWidget(snapshot.data.flags, Icons.flag),
                _BoardHeaderWidget(snapshot.data.bombCount, Icons.whatshot),
              ],
            ),
            body: BoardWidget(
                snapshot.data, _BoardWidgetCallBack(gameController)),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

/// the widget for the header parts
class _BoardHeaderWidget extends StatelessWidget {
  /// the count to be displayed
  final int count;

  /// the icon to be displayed
  final IconData icon;

  const _BoardHeaderWidget(this.count, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Row(
        children: [
          Text(
            count.toString(),
          ),
          Icon(
            icon,
          ),
        ],
      ),
    );
  }
}

/// a Class for the callbacks of the board widget
class _BoardWidgetCallBack implements BoardWidgetCallBack {
  /// the controller to relay the callbacks to
  final GameController _controller;

  const _BoardWidgetCallBack(this._controller);

  @override
  void flag(int x, int y) {
    _controller.flag(x, y);
  }

  @override
  void reveal(int x, int y) {
    _controller.reveal(x, y);
  }
}
