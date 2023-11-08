import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_terminal/providers/console_provider.dart';

class ConsoleList extends ConsumerStatefulWidget {
  const ConsoleList({super.key});

  @override
  ConsumerState<ConsoleList> createState() => _ConsoleListState();
}

class _ConsoleListState extends ConsumerState<ConsoleList> {
  late int _activeConsoleIndex;

  @override
  void initState() {
    _activeConsoleIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var consoleModelList = ref.watch(consoleProvider);

    if (consoleModelList.length > 1) {
      print(consoleModelList[0].widget == consoleModelList[1].widget);
    }

    var btns = consoleModelList
        .map(
          (e) =>
          ElevatedButton(
            onPressed: () {
              setState(() {
                print(consoleModelList.indexOf(e));
                _activeConsoleIndex = consoleModelList.indexOf(e);
              });
            },
            child: Text(e.title),
          ),
    )
        .toList();

    btns.add(ElevatedButton(
      onPressed: () {
        ref.read(consoleProvider.notifier).addConsole();
      },
      child: const Text('new'),
    ));

    return Scaffold(
        body: Column(
          children: [
            Row(
              children: btns,
            ),
            Text(_activeConsoleIndex.toString()),
            Expanded(
              child: consoleModelList[_activeConsoleIndex].widget,
            ),
          ],
        ));
  }
}
