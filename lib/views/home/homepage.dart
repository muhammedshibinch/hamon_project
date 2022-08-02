import 'package:flutter/material.dart';
import 'package:hamon_project/utils/colors.dart';
import 'package:hamon_project/utils/routers.dart';
import 'package:provider/provider.dart';
import '../../controllers/student_provider.dart';
import 'widget/section_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Provider.of<StudentProvider>(context, listen: false).getStudents();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hamon"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SectionCard(
                height: height,
                width: width,
                title: "Students",
                iconCardColor: subColor3,
                subIcon: Icons.person,
                onTap: () {
                  Navigator.pushNamed(context, studentRoute);
                }),
            SectionCard(
                height: height,
                width: width,
                title: "Subjects",
                iconCardColor: subColor1,
                subIcon: Icons.library_books_rounded,
                onTap: () {
                  Navigator.pushNamed(context, subjectRoute);
                }),
            SectionCard(
                height: height,
                width: width,
                title: "Class Rooms",
                iconCardColor: subColor2,
                subIcon: Icons.class_rounded,
                onTap: () {
                  Navigator.pushNamed(context, roomRoute);
                }),
          ],
        ),
      ),
    );
  }
}
