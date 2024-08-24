import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskie/providers/tasks_provider.dart';
import 'package:taskie/widgets/chart_bar.dart';

class ChartScreen extends ConsumerStatefulWidget {
  const ChartScreen({super.key});

  @override
  ConsumerState<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends ConsumerState<ChartScreen> {
  List<bool> isSelected = [true, false];
  int totalDayTasks(int day) {
    final allTasks = ref.read(tasksProvider);
    int ret = 0;
    final list = allTasks.where((task) {
      return task.dueDate.weekday == day;
    }).toList();
    ret = list.length;
    return ret;
  }

  int completedDayTasks(int day) {
    final allTasks = ref.read(tasksProvider);
    int ret = 0;
    final list = allTasks.where((task) {
      return task.dueDate.weekday == day && task.isCompleted;
    }).toList();
    ret = list.length;
    return ret;
  }

  int totalMonTasks(int month) {
    final allTasks = ref.read(tasksProvider);
    int ret = 0;
    final list = allTasks.where((task) {
      return task.dueDate.month == month;
    }).toList();
    ret = list.length;
    return ret;
  }

  int completedMonTasks(int month) {
    final allTasks = ref.read(tasksProvider);
    int ret = 0;
    final list = allTasks.where((task) {
      return task.dueDate.month == month && task.isCompleted;
    }).toList();
    ret = list.length;
    return ret;
  }

  String getMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        "";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final dayLabels = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];
    final monthInd = [
      (DateTime.now().month - 1) > 0 ? (DateTime.now().month - 1) : 12,
      (DateTime.now().month - 2) > 0 ? (DateTime.now().month - 2) : 11,
      DateTime.now().month,
      (DateTime.now().month + 1) % 12,
      (DateTime.now().month + 2) % 12
    ];

    int moTotal = totalDayTasks(1);
    int moComp = completedDayTasks(1);
    int tuTotal = totalDayTasks(2);
    int tuComp = completedDayTasks(2);
    int weTotal = totalDayTasks(3);
    int weComp = completedDayTasks(3);
    int thTotal = totalDayTasks(4);
    int thComp = completedDayTasks(4);
    int frTotal = totalDayTasks(5);
    int frComp = completedDayTasks(5);
    int saTotal = totalDayTasks(6);
    int saComp = completedDayTasks(6);
    int suTotal = totalDayTasks(7);
    int suComp = completedDayTasks(7);

    int m1Total = totalMonTasks(monthInd[0]);
    int m1Comp = completedMonTasks(monthInd[0]);
    int m2Total = totalMonTasks(monthInd[1]);
    int m2Comp = completedMonTasks(monthInd[1]);
    int m3Total = totalMonTasks(monthInd[2]);
    int m3Comp = completedMonTasks(monthInd[2]);
    int m4Total = totalMonTasks(monthInd[3]);
    int m4Comp = completedMonTasks(monthInd[3]);
    int m5Total = totalMonTasks(monthInd[4]);
    int m5Comp = completedMonTasks(monthInd[4]);

    final weekChart = Container(
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
                  fill: suTotal > 0 ? suComp / suTotal : 0,
                  w: 35,
                ),
                ChartBar(
                  fill: moTotal > 0 ? moComp / moTotal : 0,
                  w: 35,
                ),
                ChartBar(
                  fill: tuTotal > 0 ? tuComp / tuTotal : 0,
                  w: 35,
                ),
                ChartBar(
                  fill: weTotal > 0 ? weComp / weTotal : 0,
                  w: 35,
                ),
                ChartBar(
                  fill: thTotal > 0 ? thComp / thTotal : 0,
                  w: 35,
                ),
                ChartBar(
                  fill: frTotal > 0 ? frComp / frTotal : 0,
                  w: 35,
                ),
                ChartBar(
                  fill: saTotal > 0 ? saComp / saTotal : 0,
                  w: 35,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: dayLabels.map((day) {
              return Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )));
            }).toList(),
          )
        ],
      ),
    );
    final monthChart = Container(
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
                  fill: m1Total > 0 ? m1Comp / m1Total : 0,
                  w: 35,
                ),
                ChartBar(
                  fill: m2Total > 0 ? m2Comp / m2Total : 0,
                  w: 35,
                ),
                ChartBar(
                  fill: m3Total > 0 ? m3Comp / m3Total : 0,
                  w: 35,
                ),
                ChartBar(
                  fill: m4Total > 0 ? m4Comp / m4Total : 0,
                  w: 35,
                ),
                ChartBar(
                  fill: m5Total > 0 ? m5Comp / m5Total : 0,
                  w: 35,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: monthInd.map((month) {
              return Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        getMonth(month),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )));
            }).toList(),
          )
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            isDarkMode
                ? Image.asset('assets/images/ProgressD.png')
                : Image.asset('assets/images/Progress.png'),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Your Progress",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            ToggleButtons(
              borderRadius: BorderRadius.circular(8),
              borderColor: const Color.fromARGB(255, 121, 121, 121),
              fillColor: Colors.transparent,
              selectedColor: Theme.of(context).colorScheme.primary,
              selectedBorderColor: Theme.of(context).colorScheme.primary,
              color: Colors.grey,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              constraints: const BoxConstraints(
                minHeight: 40,
                minWidth: 80,
              ),
              isSelected: isSelected,
              onPressed: (index) {
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    if (i == index) {
                      isSelected[i] = true;
                    } else {
                      isSelected[i] = false;
                    }
                  }
                });
              },
              children: [
                Text(
                  'Week',
                  style: GoogleFonts.outfit(),
                ),
                Text(
                  'Month',
                  style: GoogleFonts.outfit(),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            isSelected[0] ? weekChart : monthChart,
          ],
        ),
      ),
    );
  }
}
