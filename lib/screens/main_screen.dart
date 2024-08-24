import 'package:flutter/material.dart';
import 'package:taskie/screens/chart_screen.dart';
import 'package:taskie/screens/home_screen.dart';
import 'package:taskie/screens/todo_list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.toggleTheme});
  final Function toggleTheme;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedScreenIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = HomeScreen(
      toggleTheme: widget.toggleTheme,
    );
    if (_selectedScreenIndex == 1) {
      activeScreen = const TodoListScreen();
    }
    if (_selectedScreenIndex == 2) {
      activeScreen = const ChartScreen();
    }
    return Scaffold(
      body: activeScreen,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 10,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(79, 156, 156, 156),
                  spreadRadius: 8,
                  blurRadius: 18,
                  offset: Offset(0, 7),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(22.0),
              topRight: Radius.circular(22.0),
            ),
            child: SizedBox(
              height: 70,
              child: BottomNavigationBar(
                onTap: _selectScreen,
                currentIndex: _selectedScreenIndex,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_rounded,
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.format_list_bulleted_sharp,
                      ),
                      label: 'todo List'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.insert_chart_outlined_outlined),
                      label: 'Charts'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
