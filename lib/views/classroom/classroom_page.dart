import 'package:flutter/material.dart';
import 'package:hamon_project/controllers/classroom_provider.dart';
import 'package:hamon_project/controllers/student_provider.dart';
import 'package:hamon_project/models/classroom_model.dart';
import 'package:hamon_project/models/student_model.dart';
import 'package:hamon_project/utils/routers.dart';
import 'package:hamon_project/utils/utils.dart';
import 'package:provider/provider.dart';
import '../../controllers/subject_provider.dart';
import '../common/subcard.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({Key? key}) : super(key: key);

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  void initState() {
    Provider.of<SubjectProvider>(context, listen: false).getSubjects();
    Provider.of<StudentProvider>(context, listen: false).getStudents();
    Provider.of<RoomProvider>(context, listen: false).allRegisteredSeats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final students =
        Provider.of<RoomProvider>(context, listen: false).getRooms();
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Class Room"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Room>>(
            future: students,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: progressIndicator);
              } else {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Room item = snapshot.data![index];
                    return SubCard(
                      height: height,
                      width: width,
                      title: item.name,
                      onTap: () {
                        Navigator.pushNamed(context, roomDetailRoute,
                            arguments: item);
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
