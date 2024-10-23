import 'package:flutter/material.dart';
import 'package:home_camera/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final Function(String)? onEditingComplete;
  const CustomTextField(
      {super.key,
      required this.label,
      this.controller,
      this.inputType,
      this.onEditingComplete,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextFormField(
            obscureText: obscureText,
            keyboardType: inputType,
            onChanged: onEditingComplete,
            decoration: InputDecoration(
                border: OutlineInputBorder(
              borderSide: const BorderSide(color: secondaryColor),
              borderRadius: BorderRadius.circular(8),
            )),
            controller: controller,
          ),
        ],
      ),
    );
  }
}
