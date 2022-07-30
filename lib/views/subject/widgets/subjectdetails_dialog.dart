import 'package:flutter/material.dart';
import 'package:hamon_project/utils/textstyles.dart';
import '../../../models/subject_model.dart';

class SubjectDetailsDialog extends StatelessWidget {
  final Subject model;
  const SubjectDetailsDialog({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(model.name, style: primaryTextStyle),
              const SizedBox(height: 15),
              Field(head: "Id", result: "${model.id}"),
              Field(head: "Teacher", result: model.teacher),
              Field(head: "Credits", result: "${model.credits}"),
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
        Text(
          result,
          style: secondaryTextStyle,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
