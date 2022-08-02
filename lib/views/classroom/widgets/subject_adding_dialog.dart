import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/classroom_provider.dart';
import '../../../controllers/subject_provider.dart';
import '../../../models/subject_model.dart';
import '../../../utils/textstyles.dart';
import '../../common/customButton.dart';

class AddSubjectDialog extends StatefulWidget {
  final int roomId;
  const AddSubjectDialog({
    Key? key,
    required this.roomId,
  }) : super(key: key);

  @override
  State<AddSubjectDialog> createState() => _AddSubjectDialogState();
}

class _AddSubjectDialogState extends State<AddSubjectDialog> {
  String? _selectedSubjectName;
  int? _selectedSubjectId;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    var subjects = Provider.of<SubjectProvider>(context).subjects;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: height * .3, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("There is no subject available now,Please select a subject",
                  style: errorStyle, textAlign: TextAlign.center),
              const SizedBox(height: 15),
              Text("Select a subject", style: primaryTextStyle),
              const SizedBox(height: 15),
              subjectSelectionDropdown(subjects),
              const SizedBox(height: 15),
              addButton(context)
            ],
          ),
        ),
      ),
    );
  }

  CustomButton addButton(BuildContext context) {
    return CustomButton(
        onTap: _selectedSubjectName != null
            ? () {
                Provider.of<RoomProvider>(context, listen: false)
                    .addSubjectToRoom(
                        roomId: widget.roomId, subjectId: _selectedSubjectId);
                Navigator.pop(context);
                setState(() {});
              }
            : null,
        title: const Text("Add"));
  }

  FormField<String> subjectSelectionDropdown(List<Subject> subjects) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              hintText: 'Select a subject',
              hintStyle: secondaryTextStyle,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          isEmpty: _selectedSubjectName == null ? true : false,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedSubjectName,
              isDense: true,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSubjectName = newValue!;
                });
              },
              items: subjects.map((Subject value) {
                return DropdownMenuItem<String>(
                  value: value.id.toString(),
                  child: Text(value.name),
                  onTap: () {
                    _selectedSubjectId = value.id;
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
