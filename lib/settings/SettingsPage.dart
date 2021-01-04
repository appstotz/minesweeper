import 'package:flutter/material.dart';
import 'package:minesweeper/game/logic/GameController.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  /// possible values for the count of the bombs
  static const _bombCounts = [5, 10, 15, 20, 25];

  /// possible values for the count of the bombs
  static const _boardSizes = [6, 8, 10, 12, 14];

  @override
  Widget build(BuildContext context) {
    var gameController = Provider.of<GameController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settings),
      ),
      body: Container(
        child: ListView(
          children: [
            _SettingsSelector(
              _bombCounts,
              AppLocalizations.of(context).bomb_count,
              gameController.bombCount,
              (selected) {
                if (selected == gameController.bombCount) {
                  return;
                }
                gameController.bombCount = selected;
                gameController.beginNewGame();
              },
            ),
            _SettingsSelector(
              _boardSizes,
              AppLocalizations.of(context).board_size,
              gameController.boardHeight,
              (selected) {
                if (selected == gameController.boardHeight) {
                  return;
                }
                gameController.boardHeight = selected;
                gameController.boardWidth = selected;
                gameController.beginNewGame();
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// a Widget to set a setting
class _SettingsSelector extends StatelessWidget {
  const _SettingsSelector(
      this._options, this._title, this._value, this._callBack,
      {Key key})
      : super(key: key);

  final List<int> _options;
  final String _title;
  final int _value;
  final Function(int value) _callBack;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(_title),
        trailing: SizedBox(
          width: 50,
          child: DropdownButtonFormField<int>(
            items: _options
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.toString()),
                  ),
                )
                .toList(),
            onChanged: (selected) {
              _callBack.call(selected);
            },
            value: _value,
          ),
        ),
      ),
    );
  }
}
