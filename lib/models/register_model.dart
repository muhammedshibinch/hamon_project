class Register {
  Register({
    required this.id,
    required this.student,
    required this.subject,
  });

  int id;
  int student;
  int subject;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        id: json["id"],
        student: json["student"],
        subject: json["subject"],
      );
}
