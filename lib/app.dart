import 'package:flutter/material.dart';
import 'package:vegas_flutter_bloc_forismatic/forismatic/forismatic.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vegas forismatic',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(72, 74, 126, 1),
        ),
      ),
      home: const AppPage(),
    );
  }
}