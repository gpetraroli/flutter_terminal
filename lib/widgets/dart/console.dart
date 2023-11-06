import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:xterm/xterm.dart';
import 'package:flutter_pty/flutter_pty.dart';

class Console extends StatefulWidget {
  const Console({Key? key}) : super(key: key);

  @override
  State<Console> createState() => _ConsoleState();
}

class _ConsoleState extends State<Console> {
  final terminal = Terminal(
    maxLines: 10000,
  );
  late final Pty pty;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.endOfFrame.then(
      (_) {
        if (mounted) _startPty();
      },
    );
  }

  void _startPty() {
    pty = Pty.start(
      shell,
      columns: terminal.viewWidth,
      rows: terminal.viewHeight,
    );

    pty.output
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal.write);

    pty.exitCode.then((code) {
      terminal.write('the process exited with exit code $code');
    });

    terminal.onOutput = (data) {
      pty.write(const Utf8Encoder().convert(data));
    };

    terminal.onResize = (w, h, pw, ph) {
      pty.resize(h, w);
    };
  }

  @override
  Widget build(BuildContext context) {
    final terminalController = TerminalController();

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

  String get shell {
    if (Platform.isMacOS || Platform.isLinux) {
      return Platform.environment['SHELL'] ?? 'bash';
    }

    if (Platform.isWindows) {
      return 'cmd.exe';
    }

    return 'sh';
  }
}
