import 'package:flutter/material.dart';
import 'package:hamon_project/controllers/student_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/textstyles.dart';

class SubCard extends StatelessWidget {
  const SubCard({
    Key? key,
    required this.height,
    required this.width,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final double height;
  final double width;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height * .12,
        width: width,
        padding:
            const EdgeInsets.only(bottom: 12, top: 12, left: 38, right: 35),
        margin: const EdgeInsets.all(8),
        decoration: cardDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: cardTitleStyle),
          ],
        ),
      ),
    );
  }

  BoxDecoration cardDecoration() {
    return BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}
