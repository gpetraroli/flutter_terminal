import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_terminal/models/console_model.dart';
import 'package:flutter_terminal/providers/console_provider.dart';

class ConsoleTabButton extends ConsumerWidget {
  final ConsoleModel consoleModel;
  final bool isActive;

  final VoidCallback onPressed;

  const ConsoleTabButton(
      {super.key,
      required this.consoleModel,
      required this.onPressed,
      required this.isActive});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(consoleProvider);

    return Container(
      height: 40,
      margin: const EdgeInsets.only(right: 1),
      padding: const EdgeInsets.only(left: 20),
      constraints: const BoxConstraints(
        maxWidth: 200,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
        color: isActive ? Colors.grey.shade300 : Colors.grey.shade200,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onPressed,
            onDoubleTap: () {
              ref
                  .read(consoleProvider.notifier)
                  .setConsoleTitle(consoleModel, 'test');
            },
            child: Text(
              consoleModel.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (ref.read(consoleProvider).length > 1)
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                padding: const EdgeInsets.all(5),
                constraints: const BoxConstraints(),
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    CircleBorder(),
                  ),
                ),
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.black,
                ),
                onPressed: () {
                  ref.read(consoleProvider.notifier).closeConsole(consoleModel);
                },
              ),
            ),
        ],
      ),
    );
  }
}
