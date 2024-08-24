import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskie/models/task.dart';
import 'package:taskie/providers/tasks_provider.dart';
import 'package:taskie/screens/task_details_screen.dart';
import 'package:taskie/widgets/custom_checkbox.dart';

class TaskWidget extends ConsumerWidget {
  const TaskWidget({
    super.key,
    required this.task,
  });

  final Task task;
  void changeCompleteness(Task task, WidgetRef ref) {
    ref.watch(tasksProvider.notifier).markTaskAsComplete(task);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void openDetailsOverlay() {
      showModalBottomSheet(
          useSafeArea: true,
          isScrollControlled: true,
          context: context,
          builder: (ctx) => TaskDetailsScreen(
                task: task,
              ),
          backgroundColor: Theme.of(context).colorScheme.onPrimary);
    }

    return InkWell(
      onTap: openDetailsOverlay,
      child: Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        margin: const EdgeInsets.only(left: 0, bottom: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0,
        shadowColor: const Color.fromARGB(255, 0, 0, 0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomCheckbox(
                value: task.isCompleted,
                onChanged: (b) {
                  changeCompleteness(task, ref);
                },
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    task.category.name.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
