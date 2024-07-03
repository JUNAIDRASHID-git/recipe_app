import 'package:flutter/material.dart';

class ScreenTitleHeading extends StatelessWidget {
  const ScreenTitleHeading({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(color: Colors.white, fontSize: 30),
    );
  }
}
