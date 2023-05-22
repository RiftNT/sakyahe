import 'package:flutter/material.dart';

class CustomIconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;

  CustomIconText({
    required this.icon,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(fontSize: 16, color: color), // Use the provided color if it's not null
        ),
      ],
    );
  }
}
