class AILog {
  final String date;
  final String time;
  final String sender;
  final String receiver;
  final String prompt;
  final String response;

  AILog({
    required this.date,
    required this.time,
    required this.sender,
    required this.receiver,
    required this.prompt,
    required this.response,
  });

  Map<String, dynamic> toJson() => {
    "date": date,
    "time": time,
    "sender": sender,
    "receiver": receiver,
    "prompt": prompt,
    "response": response,
  };
}