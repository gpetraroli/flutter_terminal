import 'package:flutter/material.dart';
import 'package:flutter_terminal/themes/default_theme.dart';
import 'package:split_view/split_view.dart';

import 'console.dart';

class SplittableConsoleContainer extends StatefulWidget {
  const SplittableConsoleContainer({Key? key}) : super(key: key);

  @override
  State<SplittableConsoleContainer> createState() =>
      _SplittableConsoleContainerState();
}

class _SplittableConsoleContainerState
    extends State<SplittableConsoleContainer> {
  var _isSplit = false;
  var _splitDirection = 'horizontal';

  _toggleSplit(String direction) {
    if (!_isSplit) {
      setState(() {
        _isSplit = true;
        _splitDirection = direction;
      });
      return;
    }

    if (_isSplit && _splitDirection == direction) {
      setState(() {
        _isSplit = false;
      });
    } else {
      setState(() {
        _splitDirection = direction;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0XFF1E1E1E),
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    _isSplit && _splitDirection == 'horizontal'
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                  ),
                ),
                onPressed: () {
                  _toggleSplit('horizontal');
                },
                icon: const Icon(Icons.vertical_split_rounded),
              ),
              IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    _isSplit && _splitDirection == 'vertical'
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                  ),
                ),
                onPressed: () {
                  _toggleSplit('vertical');
                },
                icon: const Icon(Icons.horizontal_split_rounded),
              ),
            ],
          ),
        ),
        Expanded(
          child: !_isSplit
              ? const Console()
              : SplitView(
                  gripColorActive: Colors.deepPurple,
                  gripSize: 2,
                  viewMode: _splitDirection == 'horizontal'
                      ? SplitViewMode.Horizontal
                      : SplitViewMode.Vertical,
                  children: const [
                    SplittableConsoleContainer(),
                    SplittableConsoleContainer(),
                  ],
                ),
        ),
      ],
    );
  }
}
