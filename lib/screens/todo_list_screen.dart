import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskie/providers/tasks_provider.dart';
import 'package:taskie/screens/add_task_screen.dart';
import 'package:taskie/widgets/calendar_widget.dart';
import 'package:taskie/widgets/tasks_list_widget.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(tasksProvider);

    void addTask() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const AddTaskScreen()));
    }

    return Scaffold(
      body: const Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 70),
        child: Column(
          children: [Calendar(), SizedBox(height: 25), TasksListWidget()],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addTask,
        icon: const Icon(
          Icons.add,
          size: 18,
        ),
        label: Text(
          'Create Task',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
    );
  }
}
