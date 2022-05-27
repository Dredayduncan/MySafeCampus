import 'package:flutter/material.dart';

class CustomTabLabel extends StatelessWidget {
  final String label;

  const CustomTabLabel({
    Key? key,
    required this.label
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16.0,
          fontWeight: FontWeight.w600
      )
    );
  }
}
