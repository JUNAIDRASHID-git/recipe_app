import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';

AppBar aiAppBar() {
    return AppBar(
      leading:  Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ImageIcon(
            const AssetImage("assets/logos/ai.png"),
            color: deepPurple,
          ),
        ],
      ),
      title: ShaderMask(
        shaderCallback: (bounds) {
        return   LinearGradient(
        colors: [deepPurple, Colors.purpleAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
        },
        child: Text(
          "AI CHEF",
          style: TextStyle(color: fontColor),
        ),
      ),
      backgroundColor: mainbgcolor,
    );
  }