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
    required this.iconCardColor,
    required this.subIcon,
  }) : super(key: key);

  final double height;
  final double width;
  final String title;
  final void Function()? onTap;
  final Color iconCardColor;
  final IconData subIcon;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height * .14,
        width: width,
        padding:
            const EdgeInsets.only(bottom: 12, top: 12, left: 12, right: 35),
        margin: const EdgeInsets.all(10),
        decoration: cardDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: height * .11,
              width: width * .22,
              margin: const EdgeInsets.only(right: 15),
              decoration: iconCardDecoration(iconCardColor.withOpacity(.26)),
              child: Icon(
                subIcon,
                size: width * .1,
                color: iconCardColor,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: cardTitleStyle,
              ),
            ),
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

  BoxDecoration iconCardDecoration(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
    );
  }

  Container arrowIcon() {
    return Container(
      height: height * .065,
      width: height * .065,
      decoration: const BoxDecoration(
        color: primaryColor,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
