import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
    required this.w,
  });

  final double fill;
  final double w;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: w,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FractionallySizedBox(
                heightFactor: fill,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                    color: isDarkMode
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.65),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
