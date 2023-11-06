import 'package:flutter/material.dart';
import 'package:flutter_terminal/widgets/dart/splittable_console_container.dart';

class TerminalScreen extends StatelessWidget {
  const TerminalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplittableConsoleContainer(),
    );
  }
}
