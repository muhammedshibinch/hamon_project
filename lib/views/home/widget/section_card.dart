import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/textstyles.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({
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
        height: height * .14,
        width: width,
        padding:
            const EdgeInsets.only(bottom: 12, top: 12, left: 38, right: 35),
        margin: const EdgeInsets.all(8),
        decoration: cardDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: cardTitleStyle),
            arrowIcon(),
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

  Container arrowIcon() {
    return Container(
      height: height * .075,
      width: height * .075,
      decoration: const BoxDecoration(
        color: primaryColor,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
