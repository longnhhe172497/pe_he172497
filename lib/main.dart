import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const SneakerXApp());
}

class SneakerXApp extends StatelessWidget {
  const SneakerXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sneaker-X System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Màn hình đầu tiên là Splash Screen
      home: const SplashScreen(),
    );
  }
}