import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox(
      {required this.value, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.65,
      child: GFCheckbox(
        size: GFSize.SMALL,
        inactiveBorderColor: Theme.of(context).colorScheme.primary,
        inactiveBgColor: Theme.of(context).scaffoldBackgroundColor,
        activeBgColor: Theme.of(context).colorScheme.primary,
        activeBorderColor: Colors.transparent,
        type: GFCheckboxType.circle,
        onChanged: onChanged,
        value: value,
        inactiveIcon: null,
      ),
    );
  }
}
