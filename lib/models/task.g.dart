// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      id: fields[0] as String?,
      title: fields[1] as String,
      description: fields[2] as String?,
      priority: fields[3] as Priority,
      dueDate: fields[4] as DateTime,
      isCompleted: fields[5] as bool,
      createdDate: fields[6] as DateTime?,
      updatedDate: fields[7] as DateTime?,
      category: fields[8] as TaskCategory,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.priority)
      ..writeByte(4)
      ..write(obj.dueDate)
      ..writeByte(5)
      ..write(obj.isCompleted)
      ..writeByte(6)
      ..write(obj.createdDate)
      ..writeByte(7)
      ..write(obj.updatedDate)
      ..writeByte(8)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PriorityAdapter extends TypeAdapter<Priority> {
  @override
  final int typeId = 1;

  @override
  Priority read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Priority.low;
      case 1:
        return Priority.medium;
      case 2:
        return Priority.high;
      default:
        return Priority.low;
    }
  }

  @override
  void write(BinaryWriter writer, Priority obj) {
    switch (obj) {
      case Priority.low:
        writer.writeByte(0);
        break;
      case Priority.medium:
        writer.writeByte(1);
        break;
      case Priority.high:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriorityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaskCategoryAdapter extends TypeAdapter<TaskCategory> {
  @override
  final int typeId = 2;

  @override
  TaskCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskCategory.work;
      case 1:
        return TaskCategory.personal;
      case 2:
        return TaskCategory.shopping;
      case 3:
        return TaskCategory.health;
      case 4:
        return TaskCategory.finance;
      case 5:
        return TaskCategory.home;
      case 6:
        return TaskCategory.education;
      case 7:
        return TaskCategory.errands;
      case 8:
        return TaskCategory.social;
      case 9:
        return TaskCategory.miscellaneous;
      default:
        return TaskCategory.work;
    }
  }

  @override
  void write(BinaryWriter writer, TaskCategory obj) {
    switch (obj) {
      case TaskCategory.work:
        writer.writeByte(0);
        break;
      case TaskCategory.personal:
        writer.writeByte(1);
        break;
      case TaskCategory.shopping:
        writer.writeByte(2);
        break;
      case TaskCategory.health:
        writer.writeByte(3);
        break;
      case TaskCategory.finance:
        writer.writeByte(4);
        break;
      case TaskCategory.home:
        writer.writeByte(5);
        break;
      case TaskCategory.education:
        writer.writeByte(6);
        break;
      case TaskCategory.errands:
        writer.writeByte(7);
        break;
      case TaskCategory.social:
        writer.writeByte(8);
        break;
      case TaskCategory.miscellaneous:
        writer.writeByte(9);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
