import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

part 'task.g.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  Priority priority;

  @HiveField(4)
  DateTime dueDate;

  @HiveField(5)
  bool isCompleted;

  @HiveField(6)
  DateTime createdDate;

  @HiveField(7)
  DateTime updatedDate;

  @HiveField(8)
  TaskCategory category;

  Task({
    String? id,
    required this.title,
    this.description = "",
    required this.priority,
    required this.dueDate,
    this.isCompleted = false,
    DateTime? createdDate,
    DateTime? updatedDate,
    required this.category,
  })  : id = id ?? uuid.v4(),
        createdDate = createdDate ?? DateTime.now(),
        updatedDate = updatedDate ?? DateTime.now();

  String get formattedDate {
    return formatter.format(dueDate);
  }
}

@HiveType(typeId: 1)
enum Priority {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high,
}

@HiveType(typeId: 2)
enum TaskCategory {
  @HiveField(0)
  work,
  @HiveField(1)
  personal,
  @HiveField(2)
  shopping,
  @HiveField(3)
  health,
  @HiveField(4)
  finance,
  @HiveField(5)
  home,
  @HiveField(6)
  education,
  @HiveField(7)
  errands,
  @HiveField(8)
  social,
  @HiveField(9)
  miscellaneous
}
