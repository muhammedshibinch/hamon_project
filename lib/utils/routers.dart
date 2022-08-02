import 'package:flutter/material.dart';
import 'package:hamon_project/models/classroom_model.dart';
import 'package:hamon_project/views/classroom/classroom_details_page.dart';
import 'package:hamon_project/views/classroom/classroom_page.dart';
import 'package:hamon_project/views/home/homepage.dart';
import 'package:hamon_project/views/student/student_page.dart';
import 'package:hamon_project/views/subject/subject_page.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case studentRoute:
        return MaterialPageRoute(builder: (_) => const StudentPage());
      case subjectRoute:
        return MaterialPageRoute(builder: (_) => const SubjectPage());
      case roomRoute:
        return MaterialPageRoute(builder: (_) => const RoomPage());
      case roomDetailRoute:
        Room model = settings.arguments as Room;
        return MaterialPageRoute(
            builder: (_) => RoomDetailPage(roomModel: model));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

const String homeRoute = '/';
const String studentRoute = '/student';
const String subjectRoute = '/subject';
const String roomRoute = '/room';
const String roomDetailRoute = '/roomDetail';
