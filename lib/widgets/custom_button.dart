import 'dart:ui';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color bgColor;
  final Color textColor;
  final IconData? leadingIcon;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.bgColor,
    required this.textColor,
    this.leadingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(textColor),
        backgroundColor: MaterialStateProperty.all<Color>(bgColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
      child: Row( 
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingIcon != null)
            Icon(
              leadingIcon,
              size: 20,
              color: textColor,
            ),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
