import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hamon_project/controllers/student_provider.dart';
import 'package:hamon_project/models/classroom_model.dart';
import 'package:hamon_project/models/register_model.dart';
import 'package:hamon_project/models/student_model.dart';
import 'package:hamon_project/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class RoomProvider with ChangeNotifier {
  Room? currentRoom;
  List<Register> registeredSeats = [];
  List<Student> studentsRegistered = [];
  List<Student> remainStudentsForRegistration = [];
  Register? currentRegister;

  Future<List<Room>> getRooms() async {
    final url = Uri.parse('$roomUrl?api_key=$apiKey');
    List<Room> rooms = [];
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for (var element in (body["classrooms"] as List)) {
        rooms.add(Room.fromJson(element));
      }
    } else {
      print("error found during fetching");
    }
    return rooms;
  }

  Future toGetSelectedRoomDetails(int id) async {
    final url = Uri.parse('$roomUrl$id?api_key=$apiKey');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      currentRoom = Room.fromJson(body);
      notifyListeners();
    } else {
      print("error found during fetching");
    }
  }

  void addSubjectToRoom({int? roomId, int? subjectId}) async {
    var request = http.MultipartRequest(
        'PATCH', Uri.parse('$roomUrl$roomId?api_key=$apiKey'));
    request.fields.addAll({'subject': '$subjectId'});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      toGetSelectedRoomDetails(roomId!);
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  void allRegisteredSeats() async {
    registeredSeats = [];
    final url = Uri.parse('$registerUrl?api_key=$apiKey');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for (var element in (body["registrations"] as List)) {
        print(element);
        registeredSeats.add(Register.fromJson(element));
        notifyListeners();
      }
    } else {
      print("error found during fetching");
    }
  }

  void studentRegisterationDetails(
      {required int studentId, required int subjectId}) {
    for (var element in registeredSeats) {
      if (element.student == studentId && element.subject == subjectId) {
        currentRegister = element;
        notifyListeners();
      }
    }
  }

  Future<List<Student>> studentsRegisteredInSelectedClass(
      BuildContext context, int subId) async {
    studentsRegistered = [];
    remainStudentsForRegistration = [];
    List<Student> students =
        Provider.of<StudentProvider>(context, listen: false).students;
    registeredSeats.forEach((element) {
      if (element.subject == subId) {
        students.forEach((student) {
          if (student.id == element.student) {
            studentsRegistered.add(student);
          }
        });
      }
    });
    students.forEach((student) {
      if (!studentsRegistered.contains(student)) {
        remainStudentsForRegistration.add(student);
      }
    });
    print(remainStudentsForRegistration.length);
    return studentsRegistered;
  }

  Future<void> toRegisterSeat({int? studentId, int? subjectId}) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://hamon-interviewapi.herokuapp.com/registration/?api_key=d6caE'));
    request.fields.addAll({'student': '$studentId', 'subject': '$subjectId'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      allRegisteredSeats();
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> deleteRegisteration(
      int? registerId, BuildContext context) async {
    print("reg id :$registerId====");
    final url = Uri.parse(
        'https://hamon-interviewapi.herokuapp.com/registration/$registerId?api_key=d6caE');
    var response = await http.delete(url);
    if (response.statusCode == 200) {
      allRegisteredSeats();
      Navigator.pop(context);
    }
  }
}
