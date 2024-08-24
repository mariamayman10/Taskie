import 'dart:async';
import 'package:flutter/material.dart';
import 'package:taskie/screens/main_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key, required this.toggleTheme});

  final Function toggleTheme;

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 7) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeInOut,
        );
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final img1 =
        isDarkMode ? 'assets/images/WelcomeD.png' : 'assets/images/Welcome.png';
    final img2 = isDarkMode
        ? 'assets/images/Add_tasksD.png'
        : 'assets/images/Add_tasks.png';
    final img3 =
        isDarkMode ? 'assets/images/DiaryD.png' : 'assets/images/Diary.png';
    final img4 = isDarkMode
        ? 'assets/images/IdeationD.png'
        : 'assets/images/Ideation.png';
    final img5 = isDarkMode
        ? 'assets/images/PrioritiseD.png'
        : 'assets/images/Prioritise.png';
    final img6 = isDarkMode
        ? 'assets/images/EditableD.png'
        : 'assets/images/Editable.png';
    final img7 = isDarkMode
        ? 'assets/images/CompleteD.png'
        : 'assets/images/Complete.png';
    final img8 = isDarkMode
        ? 'assets/images/ProgressD.png'
        : 'assets/images/Progress.png';
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          _buildPage(img1, 'Welcome To Taskei', ''),
          _buildPage(img2, 'Add Your Tasks',
              'Easily add new tasks to stay on top of your to-do list. Capture every detail in just a few taps.'),
          _buildPage(img3, 'Diary for Your Tasks',
              'Create a task diary to keep track of your daily plans and ensure nothing slips through the cracks.'),
          _buildPage(img4, 'Organize Your Tasks',
              'Group and categorize your tasks for better clarity and focus. Manage your workload like a pro.'),
          _buildPage(img5, 'Prioritize What Matters',
              'Modify your tasks effortlessly as plans change, ensuring your to-do list is always up to date.'),
          _buildPage(img6, 'Edit with Ease',
              'Tick off completed tasks with satisfaction, knowing you\'re making progress.'),
          _buildPage(img7, 'Mark as Completed',
              'Group and categorize your tasks for better clarity and focus. Manage your workload like a pro.'),
          _buildLastPage(context, img8, 'Track Your Progress',
              'Monitor your task completion progress over weeks and months. Celebrate your achievements!'),
        ],
      ),
    );
  }

  Widget _buildPage(String imgPath, String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imgPath),
        const SizedBox(height: 20),
        Text(title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget _buildLastPage(
      BuildContext context, String imgPath, String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imgPath),
        const SizedBox(height: 20),
        Text(title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MainScreen(toggleTheme: widget.toggleTheme)));
          },
          child: const Text('Get Started'),
        ),
      ],
    );
  }
}
