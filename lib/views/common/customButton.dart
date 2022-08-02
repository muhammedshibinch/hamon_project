import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget title;
  const CustomButton({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .3;
    final height = MediaQuery.of(context).size.height * .06;
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          primary: secondaryColor,
          fixedSize: Size(width, height),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
      child: title,
    );
  }
}
