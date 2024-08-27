import 'package:flutter/material.dart';
import 'package:todo_list_app/views/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF27ae60),
        ),
        useMaterial3: true,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF27ae60),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              color: Colors.white
            ),
          ),
          iconTheme: MaterialStateProperty.all(
            const IconThemeData(
              color: Colors.white
            )
          ),
          indicatorColor: Colors.white.withOpacity(0.3),
        ),
      ),
    );
  }
}