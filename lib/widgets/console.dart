import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:xterm/xterm.dart';
import 'package:flutter_pty/flutter_pty.dart';

class Console extends StatelessWidget {
  final Terminal terminal;
  final terminalController = TerminalController();

  Console({super.key, required this.terminal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
      child: TerminalView(
        terminal,
        textStyle: const TerminalStyle(fontSize: 17),
        controller: terminalController,
        autofocus: true,
        onSecondaryTapDown: (details, offset) async {
          // on mouse right click
        },
      ),
    );
  }
}
