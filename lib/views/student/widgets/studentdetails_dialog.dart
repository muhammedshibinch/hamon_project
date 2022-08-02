import 'package:flutter/material.dart';
import 'package:hamon_project/models/student_model.dart';
import 'package:hamon_project/utils/textstyles.dart';

class StudentDetailsDialog extends StatelessWidget {
  final Student model;
  const StudentDetailsDialog({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: height * .4, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(model.name, style: primaryTextStyle),
              const SizedBox(height: 15),
              Field(head: "Id", result: "${model.id}"),
              Field(head: "Age", result: "${model.age}"),
              Field(head: "Email", result: model.email),
            ],
          ),
        ),
      ),
    );
  }
}

class Field extends StatelessWidget {
  final String head;
  final String result;
  const Field({Key? key, required this.head, required this.result})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$head   : ", style: secondaryTextStyle),
        Expanded(
          child: Text(
            result,
            style: secondaryTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
