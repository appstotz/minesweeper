import 'package:flutter/material.dart';
import 'package:minesweeper/base/models/Field.dart';

/// the widget for a single field
class FieldWidget extends StatelessWidget {
  /// the state of this field
  final Field _field;

  /// the constructor
  const FieldWidget(this._field);

  /// the color of the boarder
  static const _borderColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    Widget content;
    final BoxBorder border = Border.all(
      color: _borderColor,
    );
    if (_field.revealed) {
      if (_field.totalBombs == 0) {
        content = null;
      } else if (_field.bomb) {
        content = _bombWidget;
      } else {
        content = _bombCountWidget(_field.totalBombs);
      }
      final Decoration decoration =
          BoxDecoration(color: Colors.white, border: border);
      return Container(
        decoration: decoration,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: content,
        ),
      );
    } else {
      if (_field.flagged) {
        content = _flaggedField;
      } else {
        content = null;
      }
      return Material(
        elevation: 5,
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: content,
        ),
      );
    }
  }

  /// the widget for the bomb
  static const Widget _bombWidget = FittedBox(
    fit: BoxFit.fill,
    child: Icon(
      Icons.whatshot_outlined,
      color: Colors.red,
    ),
  );

  /// the widget for the number of bombs
  Widget _bombCountWidget(int count) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Text(
        count.toString(),
        style: TextStyle(
          color: Colors.amber,
        ),
      ),
    );
  }

  /// the widget for flagged field
  static const Widget _flaggedField = FittedBox(
    fit: BoxFit.fill,
    child: Icon(
      Icons.flag,
      color: Colors.red,
    ),
  );
}
