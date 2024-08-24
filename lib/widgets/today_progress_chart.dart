import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskie/providers/tasks_provider.dart';
import 'package:taskie/widgets/chart_bar.dart';

class TodayProgressChart extends ConsumerWidget {
  const TodayProgressChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTasks = ref.watch(tasksProvider);
    final todayTasks = allTasks
        .where((task) =>
            task.dueDate.year == DateTime.now().year &&
            task.dueDate.month == DateTime.now().month &&
            task.dueDate.day == DateTime.now().day)
        .toList();
    final completedTasks = allTasks
        .where((task) =>
            task.dueDate.year == DateTime.now().year &&
            task.dueDate.month == DateTime.now().month &&
            task.dueDate.day == DateTime.now().day &&
            task.isCompleted)
        .toList();
    final incompletedTasks = allTasks
        .where((task) =>
            task.dueDate.year == DateTime.now().year &&
            task.dueDate.month == DateTime.now().month &&
            task.dueDate.day == DateTime.now().day &&
            !task.isCompleted)
        .toList();
    final icons = [Icons.pending_actions_rounded, Icons.check_box_rounded];

    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ChartBar(
                  fill: todayTasks.isNotEmpty
                      ? incompletedTasks.length / todayTasks.length
                      : 0,
                  w: 45,
                ),
                ChartBar(
                  fill: todayTasks.isNotEmpty
                      ? completedTasks.length / todayTasks.length
                      : 0,
                  w: 45,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: icons
                .map(
                  (icon) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        icon,
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
