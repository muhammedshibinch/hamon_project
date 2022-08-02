import 'package:flutter/material.dart';
import 'package:hamon_project/controllers/classroom_provider.dart';
import 'package:hamon_project/models/student_model.dart';
import 'package:hamon_project/utils/utils.dart';
import 'package:provider/provider.dart';
import '../../../utils/textstyles.dart';
import '../../common/customButton.dart';

class AddStudentDialog extends StatefulWidget {
  final int subjectId;
  const AddStudentDialog({
    Key? key,
    required this.subjectId,
  }) : super(key: key);

  @override
  State<AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  String? _selectedStudentName;
  int? studentId;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    var students =
        Provider.of<RoomProvider>(context).remainStudentsForRegistration;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: height * .3, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Register a student",
                  style: primaryTextStyle, textAlign: TextAlign.center),
              const SizedBox(height: 15),
              Text("Select a student", style: secondaryTextStyle),
              const SizedBox(height: 15),
              studentSelectionDropdown(students),
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
        onTap: _selectedStudentName != null
            ? () async {
                setState(() {
                  isLoading = true;
                });
                await Provider.of<RoomProvider>(context, listen: false)
                    .toRegisterSeat(
                  studentId: studentId,
                  subjectId: widget.subjectId,
                );
                isLoading = false;
                Navigator.pop(context);
              }
            : null,
        title: isLoading
            ? const Center(child: progressIndicator)
            : const Text("Add"));
  }

  FormField<String> studentSelectionDropdown(List<Student> students) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              hintText: 'Select a student',
              hintStyle: secondaryTextStyle,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          isEmpty: _selectedStudentName == null ? true : false,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedStudentName,
              isDense: true,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStudentName = newValue!;
                });
              },
              items: students.map((Student value) {
                return DropdownMenuItem<String>(
                  value: value.id.toString(),
                  child: Text(value.name),
                  onTap: () {
                    studentId = value.id;
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
