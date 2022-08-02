import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hamon_project/controllers/classroom_provider.dart';
import 'package:hamon_project/controllers/subject_provider.dart';
import 'package:hamon_project/models/classroom_model.dart';
import 'package:hamon_project/models/student_model.dart';
import 'package:hamon_project/utils/textstyles.dart';
import 'package:hamon_project/utils/utils.dart';
import 'package:provider/provider.dart';
import '../../../utils/colors.dart';
import 'person.dart';

class Space extends StatefulWidget {
  final Room model;
  final Size size;
  const Space({Key? key, required this.model, required this.size})
      : super(key: key);

  @override
  State<Space> createState() => _SpaceState();
}

class _SpaceState extends State<Space> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      findSubjectName();
    });
  }

  void findSubjectName() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<SubjectProvider>(context, listen: false)
        .findSubjectName(widget.model.subject);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<SubjectProvider>(context);
    final roomdata = Provider.of<RoomProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Person(person: widget.model.subject != null ? "teacher" : ""),
            const SizedBox(width: 45),
            subjectNameBoard(data),
          ],
        ),
        const SizedBox(height: 20),
        studentsSection(roomdata, context)
      ],
    );
  }

  Expanded studentsSection(RoomProvider roomdata, BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: widget.model.layout != "classroom"
            ? AlignmentDirectional.center
            : AlignmentDirectional.topStart,
        children: [
          FutureBuilder<List<Student>>(
              future: roomdata.studentsRegisteredInSelectedClass(
                  context, widget.model.subject ?? 0),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return progressIndicator;
                } else if (snapshot.connectionState == ConnectionState.active) {
                  return const Center(child: progressIndicator);
                } else {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.model.size,
                    gridDelegate: widget.model.layout != "classroom"
                        ? SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: widget.size.width * .3,
                            mainAxisExtent: widget.size.height * .074,
                            mainAxisSpacing: 10)
                        : const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                    itemBuilder: (context, index) {
                      if (snapshot.data!.length > index) {
                        return Center(
                            child: Person(
                          studentModel: snapshot.data![index],
                          subjectId: widget.model.subject,
                        ));
                      } else {
                        return Center(
                            child: Person(
                          subjectId: widget.model.subject,
                        ));
                      }
                    },
                  );
                }
              }),
          widget.model.layout != "classroom"
              ? Container(
                  width: widget.size.width * .3,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Container subjectNameBoard(SubjectProvider data) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: secondaryColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: secondaryColor.withOpacity(0.5),
            spreadRadius: .4,
            blurRadius: .5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(data.subjectName != "" ? data.subjectName : "No Subject",
            style: subTileStyle),
      ),
    );
  }
}
