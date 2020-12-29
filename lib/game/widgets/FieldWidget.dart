import 'package:flutter/material.dart';
import 'package:minesweeper/base/models/Field.dart';

/// the widget for a single field
class FieldWidget extends StatelessWidget {
  /// the state of this field
  final Field _field;

  /// the constructor
  const FieldWidget(this._field);

  /// size of the field (TODO: move to another place?)
  final double size = 10;

  final borderColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    Widget content;
    final BoxBorder border = Border.all(
      color: borderColor,
    );
    if (_field.revealed) {
      if (_field.totalBombs == 0) {
        content = null;
      } else if (_field.bomb) {
        content = _bombWidget();
      } else {
        content = _bombCountWidget(_field.totalBombs);
      }
      final Decoration decoration =
          BoxDecoration(color: Colors.grey.shade600, border: border);
      return Container(
        width: size,
        height: size,
        decoration: decoration,
        child: Center(
          child: content,
        ),
      );
    } else {
      if (_field.flagged) {
        content = _flaggedField();
      } else {
        content = null;
      }
      return Material(
        elevation: 5,
        child: Container(
          color: Colors.green,
          child: Center(
            child: content,
          ),
        ),
      );
    }
  }

  /// the widget for the bomb
  Widget _bombWidget() {
    return Icon(
      Icons.whatshot_outlined,
      size: 5,
      color: Colors.red,
    );
  }

  /// the widget for the number of bombs
  Widget _bombCountWidget(int count) {
    return Text(
      count.toString(),
      style: TextStyle(
        color: Colors.amber,
      ),
    );
  }

  /// the widget for flagged field
  Widget _flaggedField() {
    return Icon(
      Icons.flag,
      size: 5,
      color: Colors.red,
    );
  }
}
