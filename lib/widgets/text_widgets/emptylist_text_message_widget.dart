 import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';

Center emptyTextMessage() {
    return Center(
                  child: Text(
                  "No Recipe Found",
                  style: TextStyle(color: fontColor, fontSize: 30),
                ));
  }