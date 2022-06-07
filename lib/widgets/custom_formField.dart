import 'package:flutter/material.dart';

import '../constants.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final Widget? sendMsg;
  final Widget? suffixIcon;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool borderless;

  const CustomFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.validator,
    this.icon,
    this.sendMsg,
    this.obscureText = false,
    this.borderless = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      maxLines: null,
      style: const TextStyle(color: kDarkTextColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                borderless ? Colors.transparent : Colors.grey.withOpacity(0.3),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                borderless ? Colors.transparent : Colors.grey.withOpacity(0.3),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                borderless ? Colors.transparent : Colors.grey.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
