import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    if (_isSplit) {
      return SplitView(
        viewMode: _splitDirection == 'horizontal'
            ? SplitViewMode.Horizontal
            : SplitViewMode.Vertical,
        children: const [
          SplittableConsoleContainer(),
          SplittableConsoleContainer(),
        ],
      );
    }

    return Stack(
      children: [
        Console(),
        Positioned(
          right: 100,
          bottom: 100,
          child: IconButton(
            onPressed: () {
              setState(() {
                _isSplit = true;
              });
            },
            icon: Icon(Icons.splitscreen),
          ),
        ),
      ],
    );
  }
}
