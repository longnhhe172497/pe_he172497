import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/student_model.dart';
import 'brand_selection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Student? _student;
  Object? _loadError;

  @override
  void initState() {
    super.initState();
    _startInitProcess();
  }

  Future<void> _startInitProcess() async {
    // Task 1:
    // - Load JSON (to show identity on Splash)
    // - Keep Splash visible for exactly 3 seconds (Future.delayed)
    final loadStudentFuture = rootBundle.loadString('assets/student_info.json').then((raw) {
      final Map<String, dynamic> jsonData = json.decode(raw);
      return Student.fromJson(jsonData);
    });

    loadStudentFuture.then((student) {
      if (!mounted) return;
      setState(() {
        _student = student;
        _loadError = null;
      });
    }).catchError((e) {
      if (!mounted) return;
      setState(() {
        _loadError = e;
      });
    });

    final results = await Future.wait([
      loadStudentFuture,
      Future.delayed(const Duration(seconds: 3)),
    ]);

    final student = results[0] as Student;
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BrandSelectionScreen(student: student),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hiển thị ảnh chân dung (identity)
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/portrait.png'),
              ),
            ),
            const SizedBox(height: 24),
            if (_student != null) ...[
              Text(
                _student!.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                _student!.studentId,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 6),
              Text(
                _student!.email,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ] else if (_loadError != null) ...[
              const Text(
                "Failed to load student identity",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              const Text(
                "Check `assets/student_info.json` in pubspec.yaml",
                style: TextStyle(color: Colors.black54),
              ),
            ] else ...[
              const Text(
                "Loading identity...",
                style: TextStyle(color: Colors.black54),
              ),
            ],
            const SizedBox(height: 18),
            const CircularProgressIndicator(color: Colors.black),
          ],
        ),
      ),
    );
  }
}