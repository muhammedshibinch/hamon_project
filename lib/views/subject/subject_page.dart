import 'package:flutter/material.dart';
import 'package:hamon_project/controllers/subject_provider.dart';
import 'package:hamon_project/models/subject_model.dart';
import 'package:hamon_project/utils/utils.dart';
import 'package:provider/provider.dart';
import '../common/subcard.dart';
import 'widgets/subjectdetails_dialog.dart';

class SubjectPage extends StatelessWidget {
  const SubjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subjects =
        Provider.of<SubjectProvider>(context, listen: false).getSubjects();
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Subject>>(
            future: subjects,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: progressIndicator);
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Subject item = snapshot.data![index];
                    return SubCard(
                      height: height,
                      width: width,
                      title: item.name,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              SubjectDetailsDialog(model: item),
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
