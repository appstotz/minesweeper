import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:minesweeper/game/logic/GameController.dart';
import 'package:minesweeper/game/widgets/GamePage.dart';
import 'package:minesweeper/settings/SettingsPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  static const String GAME_ROUTE = "/game";

  static const String SETTINGS_ROUTE = "/settings";

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GameController _gameController = GameController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _gameController.beginNewGame();
  }

  /// the routes for the app
  Map<String, Widget Function(BuildContext)> _routes = Map.unmodifiable(
    Map.fromEntries([
      MapEntry(
        MyApp.GAME_ROUTE,
        (context) => GamePage(),
      ),
      MapEntry(
        MyApp.SETTINGS_ROUTE,
        (context) => SettingsPage(),
      ),
    ]),
  );

  @override
  Widget build(BuildContext context) {
    var app = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minesweeper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: MyApp.GAME_ROUTE,
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
