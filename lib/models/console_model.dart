import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_pty/flutter_pty.dart';
import 'package:flutter_terminal/widgets/console.dart';
import 'package:xterm/core.dart';
import 'dart:io';

class ConsoleModel {
  String title;

  late final Console widget;

  late final Pty pty;

  final terminal = Terminal(
    maxLines: 10000,
  );

  ConsoleModel(this.title) {
    _startPty();
    widget = Console(key: UniqueKey(), terminal: terminal);
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
