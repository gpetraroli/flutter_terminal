import 'package:flutter/material.dart';
import 'package:flutter_terminal/screens/terminal_screen.dart';
import 'package:flutter_terminal/themes/default_theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTheme,
      home: const TerminalScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
