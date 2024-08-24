import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _currentWeek = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final days = _getDaysOfWeek(_currentWeek);
    final today = DateTime.now();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 19,
                ),
                onPressed: _previousWeek,
              ),
              Text(
                DateFormat('MMMM yyyy').format(_currentWeek),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w900, fontSize: 22),
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 19,
                ),
                onPressed: _nextWeek,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 0.5,
            color: Color.fromARGB(255, 196, 196, 196),
          ),
          const SizedBox(
            height: 23,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
                .map((day) => Expanded(
                        child: Center(
                            child: Text(
                      day,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                    ))))
                .toList(),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: days.map((day) {
              bool isToday = day.day == today.day &&
                  day.month == today.month &&
                  day.year == today.year;
              return Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                  decoration: BoxDecoration(
                    color: isToday
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                          color: isToday
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSecondary,
                          fontWeight:
                              isToday ? FontWeight.bold : FontWeight.normal,
                          fontSize: 15),
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  List<DateTime> _getDaysOfWeek(DateTime startDate) {
    final startOfWeek =
        startDate.subtract(Duration(days: startDate.weekday % 7));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  void _previousWeek() {
    setState(() {
      _currentWeek = _currentWeek.subtract(const Duration(days: 7));
    });
  }

  void _nextWeek() {
    setState(() {
      _currentWeek = _currentWeek.add(const Duration(days: 7));
    });
  }
}
