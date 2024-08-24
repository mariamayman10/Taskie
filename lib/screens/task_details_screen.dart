import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskie/models/task.dart';
import 'package:taskie/providers/tasks_provider.dart';
import 'package:taskie/screens/edit_task_screen.dart';

class TaskDetailsScreen extends ConsumerWidget {
  const TaskDetailsScreen({super.key, required this.task});

  final Task task;
  void editTask(BuildContext context, Task task) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => EditTaskScreen(
              task: task,
            )));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleStyle = Theme.of(context).textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 17,
        color: Theme.of(context).colorScheme.surface);
    final bodyStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Theme.of(context).colorScheme.surface);
    ref.watch(tasksProvider);
    return Consumer(
      builder: (context, ref, child) {
        ref.watch(tasksProvider);

        return Container(
          color: Theme.of(context).colorScheme.onPrimary,
          width: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ref.watch(tasksProvider.notifier).deleteTask(task);
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.delete_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          editTask(context, task);
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).colorScheme.primary,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: titleStyle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      task.description == null || task.description == ''
                          ? 'No description set'
                          : task.description!,
                      style: bodyStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Category',
                          style: titleStyle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          task.category.name[0].toUpperCase() +
                              task.category.name.substring(1),
                          style: bodyStyle,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Priority',
                          style: titleStyle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          task.priority.name[0].toUpperCase() +
                              task.priority.name.substring(1),
                          style: bodyStyle,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status',
                          style: titleStyle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          task.isCompleted ? 'Done' : 'Pending',
                          style: bodyStyle,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Created Date',
                          style: titleStyle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          formatter.format(task.createdDate),
                          style: bodyStyle,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Due Date',
                          style: titleStyle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          formatter.format(task.dueDate),
                          style: bodyStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Updated Date',
                      style: titleStyle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      formatter.format(task.updatedDate),
                      style: bodyStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
