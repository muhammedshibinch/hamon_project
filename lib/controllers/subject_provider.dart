import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hamon_project/models/subject_model.dart';
import '../utils/api.dart';
import 'package:http/http.dart' as http;

class SubjectProvider with ChangeNotifier {
  List<Subject> subjects = [];
  String subjectName = "";
  Future<List<Subject>> getSubjects() async {
    final url = Uri.parse(subjectUrl);
    subjects = [];
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for (var element in (body["subjects"] as List)) {
        subjects.add(Subject.fromJson(element));
      }
    } else {
      print("error");
    }
    return subjects;
  }

  Future findSubjectName(int? id) async {
    subjectName = "";
    for (var element in subjects) {
      if (element.id == id) {
        subjectName = element.name;
        notifyListeners();
      }
    }
  }
}
