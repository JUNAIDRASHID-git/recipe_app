import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_app/db/models/recipedb.dart';

class ImageWidgetContainer extends StatelessWidget {
  const ImageWidgetContainer({super.key, required this.data});
  final Recipe data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      child: Image.file(File(data.image)),
    );
  }
}
