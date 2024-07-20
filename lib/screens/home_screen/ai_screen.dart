import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';

class AIScreen extends StatelessWidget {
  const AIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBody: true,
      body:  Center(
        child: Text(
          "Generate Recipe",
          style: TextStyle(fontSize: 40, color: fontColor),
        ),
      ),
    );
  }
}
