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

  factory AILog.fromJson(Map<String, dynamic> json) {
    return AILog(
      date: (json["date"] ?? "").toString(),
      time: (json["time"] ?? "").toString(),
      sender: (json["sender"] ?? "").toString(),
      receiver: (json["receiver"] ?? "").toString(),
      prompt: (json["prompt"] ?? "").toString(),
      response: (json["response"] ?? "").toString(),
    );
  }

  DateTime? get timestamp {
    try {
      // Expects: date = YYYY-MM-DD, time = HH:mm:ss
      return DateTime.parse("${date}T$time");
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> toJson() => {
    "date": date,
    "time": time,
    "sender": sender,
    "receiver": receiver,
    "prompt": prompt,
    "response": response,
  };
}