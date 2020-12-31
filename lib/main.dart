import 'package:flutter/material.dart';
import 'package:minesweeper/game/logic/GameController.dart';
import 'package:minesweeper/game/widgets/GamePage.dart';
import 'package:provider/provider.dart';

import 'base/models/Game.dart';

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

  @override
  Widget build(BuildContext context) {
    _gameController.beginNewGame(2, 2);
    return Provider(
      create: (BuildContext context) {
        return _gameController;
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: _gameController.gameSubject,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<Game> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.gameState) {
                case GameState.running:
                  return GamePage();
                case GameState.win:
                  return Container(
                    color: Colors.black,
                    child: Center(
                      child: Text("You win"),
                    ),
                  );
                case GameState.lost:
                  return Container(
                    color: Colors.black,
                    child: Center(
                      child: Text("You lose"),
                    ),
                  );
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
