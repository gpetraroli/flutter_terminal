import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_terminal/providers/console_provider.dart';
import 'package:flutter_terminal/widgets/console_tab_button.dart';

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

  void _updateActiveConsoleIndex(int index) {
    setState(() {
      _activeConsoleIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var consoleModelList = ref.watch(consoleProvider);

    var btns = consoleModelList
        .map(
          (e) => ConsoleTabButton(
            onPressed: () {
              setState(() {
                _activeConsoleIndex = consoleModelList.indexOf(e);
              });
            },
            consoleModel: e,
            isActive: consoleModelList.indexOf(e) == _activeConsoleIndex,
          ),
        )
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: Text('5'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                ...btns,
                IconButton(
                  icon: const Icon(
                    Icons.add_rounded,
                    color: Colors.black,
                    size: 20,
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.grey.shade200),
                    elevation: const MaterialStatePropertyAll(0),
                    shape: const MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    ref.read(consoleProvider.notifier).addConsole();
                    _updateActiveConsoleIndex(consoleModelList.length);
                  },
                )
              ],
            ),
            Expanded(
              child: consoleModelList[_activeConsoleIndex].widget,
            ),
          ],
        ));
  }
}
