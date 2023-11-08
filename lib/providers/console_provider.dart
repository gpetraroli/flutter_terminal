import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_terminal/models/console_model.dart';
import 'package:flutter_terminal/widgets/console.dart';

final consoleProvider =
    StateNotifierProvider<ConsoleNotifier, List<ConsoleModel>>((ref) {
  return ConsoleNotifier();
});

class ConsoleNotifier extends StateNotifier<List<ConsoleModel>> {
  ConsoleNotifier()
      : super([ConsoleModel('terminal 1', Console(key: UniqueKey()))]);

  void addConsole() {
    state = [
      ...state,
      ConsoleModel('terminal ${state.length + 1}', Console(key: UniqueKey()))
    ];
  }
}
