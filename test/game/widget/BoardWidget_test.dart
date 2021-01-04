import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/base/models/Field.dart';
import 'package:minesweeper/base/models/Game.dart';
import 'package:minesweeper/game/widgets/BoardWidget.dart';

/// create the widget for the test
Widget _createFieldWidget(Game game, BoardWidgetCallBack callBack) {
  return MaterialApp(
    home: BoardWidget(game, callBack),
  );
}

void main() {
  group('test the FieldWidget', () {
    testWidgets('display bomb', (WidgetTester tester) async {
      final Field bombHidden = Field(true, false, false, 1);
      final Field revealFive = Field(false, true, false, 5);
      final Field revealTwo = Field(false, true, false, 2);
      final Field hiddenFive = Field(false, false, false, 5);
      final Field flaggedFour = Field(false, false, true, 4);

      final game = Game([[bombHidden, revealTwo, revealTwo],[hiddenFive, hiddenFive, revealFive],[bombHidden, flaggedFour, hiddenFive]]);

      final callBack = CallBack();

      await tester.pumpWidget(
        _createFieldWidget(game, callBack),
      );

      // Verify the displayed fields
      expect(find.text("5"), findsOneWidget);
      expect(find.text('2'), findsNWidgets(2));


      //  test the flag
      final flaggedField = find.byIcon(Icons.flag);
      expect(flaggedField, findsOneWidget);

      //  TODO(tap and longPress are not working)
      // await tester.tap(flaggedField.first);
      // await tester.longPress(flaggedField);
      //
      //  // test the reveal
      // final lastField = find.byType(FieldWidget).last;
      // await tester.tap(lastField);
    });
  });
}

class CallBack implements BoardWidgetCallBack{

  var flagX = 2;

  var flagY = 1;

  var revealX = 2;

  var revealY = 2;

  @override
  void flag(int x, int y) {
    expect(x, flagX);
    expect(y, flagY);
  }

  @override
  void reveal(int x, int y) {
    expect(x, revealX);
    expect(y, revealY);
  }

}