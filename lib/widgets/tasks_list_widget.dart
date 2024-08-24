import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskie/providers/tasks_provider.dart';
import 'package:taskie/widgets/task_widget.dart';

class TasksListWidget extends ConsumerWidget {
  const TasksListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTasks = ref.watch(tasksProvider);
    final startOfWeek =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    final endOfWeek = DateTime.now()
        .add(Duration(days: DateTime.daysPerWeek - DateTime.now().weekday));
    final todayTasks = allTasks
        .where((task) =>
            task.dueDate.year == DateTime.now().year &&
            task.dueDate.month == DateTime.now().month &&
            task.dueDate.day == DateTime.now().day &&
            !task.isCompleted)
        .toList();
    final tomorrowTasks = allTasks
        .where((task) =>
            task.dueDate.year == DateTime.now().year &&
            task.dueDate.month == DateTime.now().month &&
            task.dueDate.day == DateTime.now().day + 1 &&
            !task.isCompleted)
        .toList();
    final weekTasks = allTasks
        .where((task) =>
            task.dueDate.isAfter(startOfWeek) &&
            task.dueDate.isBefore(endOfWeek) &&
            !task.isCompleted)
        .toList();

    Widget content1 = Text(
      'No Pending tasks',
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: const Color.fromARGB(255, 110, 110, 110)),
      textAlign: TextAlign.left,
    );
    if (todayTasks.isNotEmpty) {
      content1 = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: todayTasks.map((task) {
          return TaskWidget(
            task: task,
          );
        }).toList(),
      );
    }
    final todayContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_month,
              color: Color(0xFF7a83f2),
              size: 21,
            ),
            const SizedBox(width: 7),
            Text(
              "Today",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7a83f2)),
            ),
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        content1,
      ],
    );

    Widget content2 = Text(
      'No Pending tasks',
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: const Color.fromARGB(255, 110, 110, 110)),
      textAlign: TextAlign.left,
    );
    if (tomorrowTasks.isNotEmpty) {
      content2 = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: tomorrowTasks.map((task) {
          return TaskWidget(
            task: task,
          );
        }).toList(),
      );
    }
    final tomorrowContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_month,
              color: Color(0xFF7a83f2),
              size: 21,
            ),
            const SizedBox(width: 7),
            Text(
              "Tomorrow",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7a83f2)),
            ),
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        content2,
      ],
    );

    Widget content3 = Text(
      'No Pending tasks',
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: const Color.fromARGB(255, 110, 110, 110)),
      textAlign: TextAlign.left,
    );
    if (weekTasks.isNotEmpty) {
      content3 = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: weekTasks.map((task) {
          return TaskWidget(
            task: task,
          );
        }).toList(),
      );
    }
    final weekContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_month,
              color: Color(0xFF7a83f2),
              size: 21,
            ),
            const SizedBox(width: 7),
            Text(
              "Week",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7a83f2)),
            ),
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        content3,
      ],
    );

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            todayContent,
            const SizedBox(
              height: 25,
            ),
            tomorrowContent,
            const SizedBox(
              height: 25,
            ),
            weekContent,
          ],
        ),
      ),
    );
  }
}
