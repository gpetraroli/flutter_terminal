import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_terminal/screens/console_list_screen.dart';
import 'package:flutter_terminal/themes/default_theme.dart';
import 'package:window_manager/window_manager.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );

  windowManager.waitUntilReadyToShow().then((_) async {
    // await windowManager.setAsFrameless();
  });
  // windowManager.setBackgroundColor(const Color(0x00fff000));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTheme,
      home: const ConsoleList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
