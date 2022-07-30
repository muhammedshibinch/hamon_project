import 'package:flutter/material.dart';
import 'package:hamon_project/models/student_model.dart';
import 'package:hamon_project/views/common/subcard.dart';
import 'package:provider/provider.dart';

import '../../controllers/student_provider.dart';
import 'widgets/studentdetails_dialog.dart';

class StudentPage extends StatelessWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final students =
        Provider.of<StudentProvider>(context, listen: false).getStudents();
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Student>>(
            future: students,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Student item = snapshot.data![index];
                    return SubCard(
                      height: height,
                      width: width,
                      title: item.name,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              StudentDetailsDialog(model: item),
                        );
                      },
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
