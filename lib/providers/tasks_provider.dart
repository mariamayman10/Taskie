import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskie/models/task.dart';

class TasksNotifier extends StateNotifier<List<Task>> {
  final Box<Task> _tasksBox;

  TasksNotifier()
      : _tasksBox = Hive.box<Task>('tasks'),
        super([]) {
    _loadTasks();
  }

  void _loadTasks() {
    state = _tasksBox.values.toList();
    _tasksBox.listenable().addListener(() {
      state = _tasksBox.values.toList();
    });
  }

  void addTask(Task task) {
    _tasksBox.add(task);
    _loadTasks();
  }

  void updateTask(Task task) {
    int index = _tasksBox.values.toList().indexOf(task);
    _tasksBox.putAt(index, task);
    _loadTasks();
  }

  void updateComplete(Task task) {
    final index = state.indexOf(task);
    if (index != -1) {
      task.isCompleted = !task.isCompleted;
      _tasksBox.putAt(index, task);
    }
  }

  void deleteTask(Task task) {
    final key = _tasksBox.keys.firstWhere((k) => _tasksBox.get(k) == task);
    _tasksBox.delete(key);
    _loadTasks();
  }

  void markTaskAsComplete(Task task) {
    task.isCompleted == true
        ? task.isCompleted = false
        : task.isCompleted = true;
    _loadTasks();
  }
}

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});
