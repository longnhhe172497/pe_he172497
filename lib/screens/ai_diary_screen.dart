import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/ai_log_model.dart';
import 'ai_detail_view.dart'; // Sẽ tạo ở bước sau

class AIDiaryScreen extends StatelessWidget {
  const AIDiaryScreen({super.key});

  Future<List<AILog>> _loadLogs() async {
    final raw = await rootBundle.loadString('assets/ai_prompt_history.json');
    final decoded = json.decode(raw);
    final list = (decoded as List)
        .whereType<Map<String, dynamic>>()
        .map((m) => AILog.fromJson(m))
        .toList();

    list.sort((a, b) {
      final at = a.timestamp;
      final bt = b.timestamp;
      if (at == null && bt == null) return 0;
      if (at == null) return 1;
      if (bt == null) return -1;
      return at.compareTo(bt);
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI PROMPT DIARY")),
      body: FutureBuilder<List<AILog>>(
        future: _loadLogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Failed to load AI diary.\n${snapshot.error}",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final logs = snapshot.data ?? const <AILog>[];
          if (logs.isEmpty) {
            return const Center(child: Text("No AI prompts logged yet."));
          }

          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              final time = log.time; // already HH:mm:ss
              return TimelineTile(
                sender: log.sender,
                receiver: log.receiver,
                time: time,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AIDetailView(log: log)),
                  );
                },
              );
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