import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(const MealsApp());
}

class MealsApp extends StatelessWidget {
  const MealsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF8E1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8D6E63),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 2,
        ),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF8D6E63),
          secondary: Color(0xFF5D4037),
        ),
        useMaterial3: true,
      ),
      home: const CategoriesScreen(),
    );
  }
}
