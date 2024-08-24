import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskie/models/task.dart';
import 'package:taskie/screens/checkin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  Hive.registerAdapter(TaskCategoryAdapter());
  await Hive.openBox<Task>('tasks');
  var intro = await Hive.openBox('intro');
  if (intro.get('isFirstTime') == null) {
    await intro.put('isFirstTime', true);
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;

  void toggleTheme() {
    setState(() {
      themeMode =
          themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFF85573),
          onPrimary: Color(0xFFFFFFFF),
          secondary: Color(0xFFF85573),
          onSecondary: Color.fromARGB(255, 50, 50, 50),
          surface: Color.fromARGB(246, 34, 34, 34),
          onSurface: Color(0xDD222222),
          error: Colors.red,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 244, 244),
        cardColor: Colors.white,
        textTheme:
            GoogleFonts.outfitTextTheme(Theme.of(context).textTheme.copyWith(
                  headlineLarge: const TextStyle(
                      color: Color(0xFF4d5054),
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                  headlineSmall: const TextStyle(
                    color: Color(0xFF4d5054),
                  ),
                  bodyLarge:
                      const TextStyle(color: Color(0xFF4d5054), fontSize: 16),
                  bodyMedium:
                      const TextStyle(color: Color(0xFF4d5054), fontSize: 14),
                )),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFE5776),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF85573),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFFF85573),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFFBFBFB),
          selectedItemColor: Color(0xFFF85573),
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(size: 33),
          unselectedIconTheme: IconThemeData(size: 30),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        dropdownMenuTheme: const DropdownMenuThemeData(
          textStyle: TextStyle(color: Color.fromARGB(255, 49, 49, 49)),
        ),
        datePickerTheme: DatePickerThemeData(
            backgroundColor: Theme.of(context).colorScheme.onSecondary),
        dividerColor: Colors.grey[300],
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFFf95405),
          onPrimary: Color.fromARGB(205, 0, 0, 0),
          secondary: Color(0xFFf95405),
          onSecondary: Color(0xFFB7B7B7),
          surface: Color(0xFFF5F5F5),
          onSurface: Colors.black87,
          error: Colors.red,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 18, 18),
        cardColor: Colors.white,
        textTheme:
            GoogleFonts.outfitTextTheme(Theme.of(context).textTheme.copyWith(
                  headlineLarge: const TextStyle(
                      color: Color(0xFFB7B7B7),
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                  headlineSmall: const TextStyle(
                    color: Color(0xFFB7B7B7),
                  ),
                  bodyLarge:
                      const TextStyle(color: Color(0xFFB7B7B7), fontSize: 16),
                  bodyMedium:
                      const TextStyle(color: Color(0xFFB7B7B7), fontSize: 14),
                )),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFf95405),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFf95405),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFFf95405),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF000000),
          selectedItemColor: Color(0xFFf95405),
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(size: 33),
          unselectedIconTheme: IconThemeData(size: 30),
        ),
        dropdownMenuTheme: const DropdownMenuThemeData(
          textStyle: TextStyle(color: Color.fromARGB(255, 167, 167, 167)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle:
              const TextStyle(color: Color.fromARGB(255, 167, 167, 167)),
          filled: true,
          fillColor: const Color(0xFF333333),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Color.fromARGB(255, 27, 27, 27),
          headerForegroundColor: Color.fromARGB(255, 125, 125, 125),
          dayForegroundColor:
              WidgetStatePropertyAll(Color.fromARGB(255, 125, 125, 125)),
          weekdayStyle: TextStyle(color: Color.fromARGB(255, 125, 125, 125)),
          yearForegroundColor:
              WidgetStatePropertyAll(Color.fromARGB(255, 125, 125, 125)),
        ),
      ),
      home: CheckIntroScreen(toggleTheme: toggleTheme),
    );
  }
}
