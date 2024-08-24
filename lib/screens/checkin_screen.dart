import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskie/screens/intro_screen.dart';
import 'package:taskie/screens/main_screen.dart';

class CheckIntroScreen extends StatefulWidget {
  const CheckIntroScreen({super.key, required this.toggleTheme});

  final Function toggleTheme;
  @override
  State<CheckIntroScreen> createState() => _CheckIntroScreenState();
}

class _CheckIntroScreenState extends State<CheckIntroScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfFirstTime();
    });
  }

  void _checkIfFirstTime() async {
    var box = Hive.box('intro');
    bool? isFirstTime = box.get('isFirstTime');
    if (isFirstTime == true) {
      await box.put('isFirstTime', false);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => IntroScreen(
                    toggleTheme: widget.toggleTheme,
                  )));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MainScreen(
                    toggleTheme: widget.toggleTheme,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
