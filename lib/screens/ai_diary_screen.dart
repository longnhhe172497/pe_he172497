import 'package:flutter/material.dart';
import '../models/ai_log_model.dart';
import 'ai_detail_view.dart'; // Sẽ tạo ở bước sau

class AIDiaryScreen extends StatelessWidget {
  const AIDiaryScreen({super.key});

  // Mock data dựa trên yêu cầu cấu trúc của Task 3
  final List<AILog> logs = const []; // Trong thực tế, bạn sẽ lấy List này từ State Management

  @override
  Widget build(BuildContext context) {
    // Sắp xếp theo thời gian (giả định list đã được add theo thứ tự)
    return Scaffold(
      appBar: AppBar(title: const Text("AI PROMPT DIARY")),
      body: ListView.builder(
        itemCount: 5, // Ví dụ hiển thị 5 item
        itemBuilder: (context, index) {
          return TimelineTile(
            sender: "SE1871-KS User",
            receiver: "Gemini AI",
            time: "14:30:${15 + index}",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const AIDetailView(response: "Full AI Response Detail here...")
              ));
            },
          );
        },
      ),
    );
  }
}

class TimelineTile extends StatelessWidget {
  final String sender, receiver, time;
  final VoidCallback onTap;

  const TimelineTile({super.key, required this.sender, required this.receiver, required this.time, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.circle, size: 12, color: Colors.blue),
          Container(width: 2, height: 30, color: Colors.grey[300]),
        ],
      ),
      title: Text("From: $sender ➔ To: $receiver"),
      subtitle: Text("Time: $time"),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}