import 'package:flutter/material.dart';
import 'package:lab2/core/di/dependency_injection.dart';
import 'package:lab2/presentation/screens/home_screen.dart';
import 'package:lab2/presentation/theme/app_theme.dart';

void main() {
  DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: const HomeScreen(),
    );
  }
}
