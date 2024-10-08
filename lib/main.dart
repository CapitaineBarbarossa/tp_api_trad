import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/language_selection_screen.dart';

void main() {
  runApp(const TranslateApp());
}

class TranslateApp extends StatelessWidget {
  const TranslateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translate App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LanguageSelectionScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
