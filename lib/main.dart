import 'package:flutter/material.dart';
import 'package:minesweeper/game/logic/GameController.dart';
import 'package:minesweeper/game/widgets/GamePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GameController _gameController = GameController();

  @override
  void dispose() {
    super.dispose();
  }

  static const String GAME_ROUTE = "/game";

  static const String SETTINGS_ROUTE = "/settings";

  /// the routes for the app
  Map<String, Widget Function(BuildContext)> _routes = Map.unmodifiable(
    Map.fromEntries([
      MapEntry(
        GAME_ROUTE,
        (context) => GamePage(),
      ),
    ]),
  );

  @override
  Widget build(BuildContext context) {
    _gameController.beginNewGame(2, 2);

    var app = MaterialApp(
      title: 'Minesweeper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: GAME_ROUTE,
      routes: _routes,
    );

    return Provider(
      create: (BuildContext context) {
        return _gameController;
      },
      child: app,
    );
  }
}
