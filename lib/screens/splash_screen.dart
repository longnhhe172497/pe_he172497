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
  @override
  void initState() {
    super.initState();
    _startInitProcess();
  }

  Future<void> _startInitProcess() async {
    // Task 1: Sử dụng Future.wait để đồng bộ hóa việc load data và thời gian chờ
    final results = await Future.wait([
      rootBundle.loadString('assets/student_info.json'), // Load JSON
      Future.delayed(const Duration(seconds: 3)),      // Chờ đúng 3s
    ]);

    // Chuyển đổi dữ liệu JSON thành Object Student thông qua Model class
    final Map<String, dynamic> jsonData = json.decode(results[0] as String);
    final student = Student.fromJson(jsonData);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BrandSelectionScreen(student: student),
        ),
      );
    }
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
            const CircularProgressIndicator(color: Colors.black),
            const SizedBox(height: 16),
            const Text(
              "SNEAKER-X SYSTEM",
              style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}