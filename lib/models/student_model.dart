class Student {
  final String name;
  final String studentId;
  final String email;

  Student({required this.name, required this.studentId, required this.email});

  // Chuyển đổi từ JSON sang Object Student
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'] ?? '',
      studentId: json['student_id'] ?? '',
      email: json['email'] ?? '',
    );
  }
}