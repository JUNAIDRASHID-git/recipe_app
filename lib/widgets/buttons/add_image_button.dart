 import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';

Padding addImageButton(void Function()? onPressed) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: FloatingActionButton(
          backgroundColor: floatActionButtonColor,
          onPressed: onPressed,
          child: Icon(
            Icons.add_a_photo_outlined,
            color: fontColor,
          )),
    );
  }