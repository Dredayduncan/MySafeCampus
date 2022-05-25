import 'dart:io';

import 'package:flutter/material.dart';
import '../constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String btnName;
  final Color? backgroundColor;
  final IconData? buttonIcon;
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.btnName,
    this.backgroundColor = kDefaultBackground,
    this.buttonIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              btnName,
              style: TextStyle(
                fontFamily: 'Quattrocentro',
                fontSize: 18,
                color: backgroundColor == kDefaultBackground
                    ? kWhiteTextColor
                    : kDarkTextColor,
              ),
            ),
            const SizedBox(width: 10),
            buttonIcon != null ? Icon(buttonIcon) : const SizedBox(width: 0)
          ],
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shadowColor: MaterialStateProperty.all(
            Colors.black45,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
