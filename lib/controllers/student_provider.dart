import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hamon_project/utils/api.dart';
import 'package:http/http.dart' as http;
import '../models/student_model.dart';

class StudentProvider with ChangeNotifier {
  Future<List<Student>> getStudents() async {
    final url = Uri.parse(studentUrl);
    List<Student> students = [];
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for (var element in (body["students"] as List)) {
        students.add(Student.fromJson(element));
      }
    } else {
      print("error found during fetching");
    }
    return students;
  }
}
