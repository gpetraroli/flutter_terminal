import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_terminal/models/console_model.dart';
import 'package:flutter_terminal/widgets/console.dart';

final consoleProvider =
    StateNotifierProvider<ConsoleNotifier, List<ConsoleModel>>((ref) {
  return ConsoleNotifier();
});

class ConsoleNotifier extends StateNotifier<List<ConsoleModel>> {
  var _counter = 2;

  ConsoleNotifier() : super([ConsoleModel('terminal 1')]);

  void addConsole() {
    state = [
      ...state,
      ConsoleModel('terminal $_counter'),
    ];
    _counter++;
  }

  void closeConsole(ConsoleModel consoleModel) {
    if (state.length == 1) {
      return;
    }

    state.remove(consoleModel);
    state = [...state];
  }

  void setConsoleTitle(ConsoleModel consoleModel, String title) {
    consoleModel.title = title;
    state = [...state];
  }
}
