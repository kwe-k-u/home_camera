import 'package:flutter/material.dart';
import 'package:home_camera/utils/constants.dart';

class CustomRoundedButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  final double? width;
  const CustomRoundedButton(
      {super.key, this.width, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: primaryColor,
      minWidth: width ?? MediaQuery.of(context).size.width * 0.7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textTheme: Theme.of(context).buttonTheme.textTheme,
      onPressed: onTap,
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.w400, color: secondaryColor),
      ),
    );
  }
}
