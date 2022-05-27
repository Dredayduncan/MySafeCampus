import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final Widget? sendMsg;
  final Widget? suffixIcon;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool borderless;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.validator,
    required this.icon,
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
      style: const TextStyle(color: kDarkTextColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            suffixIcon ?? const SizedBox(width: 0),
            sendMsg ?? const SizedBox(width: 0),
          ],
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
