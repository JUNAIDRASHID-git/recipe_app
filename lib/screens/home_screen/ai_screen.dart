import 'package:flutter/material.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';

class AIScreen extends StatelessWidget {
  const AIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainbgcolor,
      extendBody: true,
      body: const Center(
        child: Text(
          "Generate Recipe",
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
      ),
    );
  }
}
