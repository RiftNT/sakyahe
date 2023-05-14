import 'package:flutter/material.dart';

class CustomIconText extends StatelessWidget {
  final IconData icon;
  final String text;

  CustomIconText({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
