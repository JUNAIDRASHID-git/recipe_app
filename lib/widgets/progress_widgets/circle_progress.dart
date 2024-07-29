import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';

class AILoadingWidget extends StatelessWidget {
  const AILoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(fontColor),
        strokeWidth: 3.0,
      ),
    );
  }
}