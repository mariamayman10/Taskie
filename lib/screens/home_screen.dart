import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:taskie/widgets/task_widget.dart';
import 'package:taskie/providers/tasks_provider.dart';
import 'package:taskie/widgets/today_progress_chart.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.toggleTheme});

  final Function toggleTheme;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTasks = ref.watch(tasksProvider);
    final todayTasks = allTasks
        .where((task) =>
            task.dueDate.year == DateTime.now().year &&
            task.dueDate.month == DateTime.now().month &&
            task.dueDate.day == DateTime.now().day)
        .toList();
    final completed = todayTasks.where((task) => task.isCompleted);
    final incompleted = todayTasks.where((task) => !task.isCompleted);

    String getFormattedDate() {
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('EEE MMM yyyy');
      return formatter.format(now);
    }

    return (Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: Theme.of(context).brightness == Brightness.dark
                      ? [
                          const Color(0xFFf95405),
                          const Color.fromARGB(255, 255, 128, 70)
                        ]
                      : [
                          const Color(0xFFF85573),
                          const Color.fromARGB(255, 255, 109, 136)
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height));
              },
              child: Text(
                'Taskie',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                icon: Icon(
                  Icons.brightness_6_outlined,
                  size: 28,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  toggleTheme();
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 27,
                ),
                Text(
                  getFormattedDate(),
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 34,
                          color: Color.fromARGB(255, 126, 126, 126))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Your Progress",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary)),
                ),
                const TodayProgressChart(),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  incompleted.isNotEmpty ? "Pending Tasks" : "No Pending Tasks",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                Column(
                  children: incompleted.map((task) {
                    return TaskWidget(task: task);
                  }).toList(),
                ),
                Text(
                  completed.isNotEmpty
                      ? "Completed Tasks"
                      : "No Completed Tasks",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                Column(
                  children: completed.map((task) {
                    return TaskWidget(task: task);
                  }).toList(),
                ),
              ],
            ),
          ),
        )));
  }
}
