import 'package:flutter/material.dart';

class AIDetailView extends StatelessWidget {
  final String response;
  const AIDetailView({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI RESPONSE DETAIL")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!)
                ),
                child: SingleChildScrollView(
                  child: Text(
                    response,
                    style: const TextStyle(fontSize: 16, height: 1.5, fontFamily: 'monospace'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("CLOSE"),
              ),
            )
          ],
        ),
      ),
    );
  }
}