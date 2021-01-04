import 'package:flutter/material.dart';
import 'package:minesweeper/base/models/Game.dart';
import 'package:minesweeper/game/logic/GameController.dart';
import 'package:minesweeper/game/widgets/BoardWidget.dart';
import 'package:minesweeper/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// the page for the game
class GamePage extends StatelessWidget {
  const GamePage();

  /// the button to restart the game for the dialogs
  Widget _restartButton(BuildContext context, GameController gameController) {
    return RaisedButton(
      onPressed: () {
        gameController.beginNewGame();
        Navigator.pop(context);
      },
      child: Text(AppLocalizations.of(context).restart),
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
          _showDialog(
            context,
            gameController,
            AppLocalizations.of(context).you_win,
            Key("winDialog"),
          );
          break;
        case GameState.lost:
          _showDialog(
            context,
            gameController,
            AppLocalizations.of(context).you_lose,
            Key("loseDialog"),
          );
          break;
      }
    });

    return StreamBuilder(
      stream: gameController.gameSubject,
      builder: (BuildContext context, AsyncSnapshot<Game> snapshot) {
        if (snapshot.hasData) {
          var bombCount;
          if (snapshot.data.bombCount == 0) {
            bombCount = gameController.bombCount;
          } else {
            bombCount = snapshot.data.bombCount;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).game),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.pushNamed(context, MyApp.SETTINGS_ROUTE);
                  },
                ),
                _BoardHeaderWidget(snapshot.data.flags, Icons.flag),
                _BoardHeaderWidget(bombCount, Icons.whatshot),
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
