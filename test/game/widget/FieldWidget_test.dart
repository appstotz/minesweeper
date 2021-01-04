import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/base/models/Field.dart';
import 'package:minesweeper/game/widgets/FieldWidget.dart';

/// create the widget for the test
Widget _createFieldWidget(Field field) {
  return MaterialApp(
    home: FieldWidget(field),
  );
}

void main() {
  group('test the FieldWidget', () {
    testWidgets('display bomb', (WidgetTester tester) async {
      final Field bomb = Field(true, true, false, 1);

      await tester.pumpWidget(
        _createFieldWidget(bomb),
      );

      // Verify that the bomb is displayed
      expect(find.byIcon(Icons.whatshot_outlined), findsOneWidget);
      expect(find.text('1'), findsNothing);

      final Field bombHidden = Field(true, false, false, 1);

      await tester.pumpWidget(_createFieldWidget(bombHidden));

      expect(find.byIcon(Icons.whatshot_outlined), findsNothing);
      expect(find.text('1'), findsNothing);
    });

    testWidgets('display flagged', (WidgetTester tester) async {
      final Field flagged = Field(true, false, true, 1);
      await tester.pumpWidget(
        _createFieldWidget(flagged),
      );

      // Verify that the flag is displayed
      expect(find.byIcon(Icons.flag), findsOneWidget);
      expect(find.text('1'), findsNothing);
    });

    testWidgets('display count', (WidgetTester tester) async {
      final Field hidden = Field(false, false, false, 1);
      await tester.pumpWidget(
        _createFieldWidget(hidden),
      );

      // Verify that the count is not displayed
      expect(find.byIcon(Icons.flag), findsNothing);
      expect(find.text(hidden.totalBombs.toString()), findsNothing);

      final Field revealed = Field(false, true, false, 1);
      await tester.pumpWidget(
        _createFieldWidget(revealed),
      );

      // Verify that the count is displayed
      expect(find.byIcon(Icons.flag), findsNothing);
      expect(find.text(hidden.totalBombs.toString()), findsOneWidget);
    });
  });
}
