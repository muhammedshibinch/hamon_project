import 'package:flutter/material.dart';
import 'package:hamon_project/controllers/classroom_provider.dart';
import 'package:hamon_project/models/register_model.dart';
import 'package:hamon_project/models/student_model.dart';
import 'package:hamon_project/utils/colors.dart';
import 'package:hamon_project/utils/utils.dart';
import 'package:hamon_project/views/classroom/widgets/student_registeration_dialog.dart';
import 'package:hamon_project/views/common/customButton.dart';
import 'package:provider/provider.dart';
import '../../../utils/textstyles.dart';
import '../../student/widgets/studentdetails_dialog.dart';

class Person extends StatelessWidget {
  final String person;
  final int? subjectId;
  final Student? studentModel;
  const Person({Key? key, this.person = "", this.studentModel, this.subjectId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(subjectId);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return InkWell(
      onLongPress: studentModel != null
          ? () => showDialog(
              context: context,
              builder: (context) =>
                  DeleteDialog(model: studentModel!, subjectId: subjectId!))
          : null,
      onTap: person == ""
          ? () => showDialog(
              context: context,
              builder: (context) => studentModel != null
                  ? StudentDetailsDialog(
                      model: studentModel!,
                    )
                  : AddStudentDialog(subjectId: subjectId!))
          : null,
      child: Container(
        height: width * .16,
        width: width * .16,
        decoration: BoxDecoration(
          color: person == ""
              ? studentModel != null
                  ? subColor3OpcaColor
                  : white
              : subColor1OpcaColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          Icons.person,
          size: width * .08,
          color: person != "" ? blackopa : blackopa,
        ),
      ),
    );
  }
}

class DeleteDialog extends StatefulWidget {
  final Student model;
  final int subjectId;
  const DeleteDialog({Key? key, required this.model, required this.subjectId})
      : super(key: key);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  bool _isLoading = false;

  Future<void> deleteRegisteration(
      {required int studentId, required int subjectId}) async {
    setState(() {
      _isLoading = true;
    });
    final data = Provider.of<RoomProvider>(context, listen: false);
    data.registeredSeats.forEach((element) {
      if (element.student == studentId && element.subject == subjectId) {
        print("delete it call");
        data.deleteRegisteration(element.id, context).then((value) {
          setState(() {
            _isLoading = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text(
          "Are you want to remove ${widget.model.name} from this class?",
          style: primaryTextStyle),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomButton(
                onTap: _isLoading
                    ? () {}
                    : () async {
                        await deleteRegisteration(
                            studentId: widget.model.id,
                            subjectId: widget.subjectId);
                      },
                title: _isLoading
                    ? const Center(
                        child: progressIndicator,
                      )
                    : Text("Yes", style: deleteButtonStyle)),
            CustomButton(
                onTap: () => _isLoading ? null : Navigator.pop(context),
                title: Text("No", style: subTileStyle))
          ],
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
