import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskie/models/task.dart';
import 'package:taskie/providers/tasks_provider.dart';

class EditTaskScreen extends ConsumerStatefulWidget {
  const EditTaskScreen({super.key, required this.task});

  final Task task;

  @override
  ConsumerState<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends ConsumerState<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  var _selectedCategory = TaskCategory.miscellaneous;
  var _selectedPriority = Priority.low;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text =
        widget.task.description != null ? widget.task.description! : '';
    _selectedCategory = widget.task.category;
    _selectedPriority = widget.task.priority;
    _selectedDate = widget.task.dueDate;
    _dateController.text = _selectedDate!.toLocal().toString().split(' ')[0];
  }

  void _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.black,
              onSurface: Theme.of(context).colorScheme.surface,
            ),
          ),
          child: child!,
        );
      },
      helpText: "Select Due Date",
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: lastDate,
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = pickedDate.toLocal().toString().split(' ')[0];
        _selectedDate = pickedDate;
      });
    }
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      final updatedTask = widget.task;
      updatedTask.title = _titleController.text;
      updatedTask.description = _descriptionController.text;
      updatedTask.category = _selectedCategory;
      updatedTask.priority = _selectedPriority;
      updatedTask.dueDate = _selectedDate!;
      ref.watch(tasksProvider.notifier).updateTask(updatedTask);
      Navigator.pop(context);
    }
  }

  void _resetForm() {
    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _selectedCategory = TaskCategory.miscellaneous;
      _selectedPriority = Priority.low;
      _dateController.clear();
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 55),
            child: Column(children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              isDarkMode
                  ? Image.asset('assets/images/EditableD.png')
                  : Image.asset('assets/images/Editable.png'),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Edit Task',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 28),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(label: Text('Title')),
                      maxLength: 50,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length <= 1 ||
                            value.trim().length > 50) {
                          return 'Must be between 1 and 50 characters.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                          label: Text('Description (optional)')),
                      maxLength: 100,
                      validator: (value) => value == null ? '' : null,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            value: _selectedCategory,
                            style: Theme.of(context).textTheme.bodyLarge,
                            dropdownColor:
                                Theme.of(context).colorScheme.onPrimary,
                            items: [
                              for (final category in TaskCategory.values)
                                DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name[0].toUpperCase() +
                                      category.name.substring(1)),
                                ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: DropdownButtonFormField(
                            value: _selectedPriority,
                            style: Theme.of(context).textTheme.bodyLarge,
                            dropdownColor:
                                Theme.of(context).colorScheme.onPrimary,
                            items: [
                              for (final priority in Priority.values)
                                DropdownMenuItem(
                                  value: priority,
                                  child: Text(priority.name[0].toUpperCase() +
                                      priority.name.substring(1)),
                                ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedPriority = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _dateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Select due date',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.calendar_month,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                                onPressed: () {
                                  _selectDate(context);
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a date';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: _resetForm,
                              child: Text(
                                'Reset',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _saveItem,
                              child: Text(
                                'Save',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
