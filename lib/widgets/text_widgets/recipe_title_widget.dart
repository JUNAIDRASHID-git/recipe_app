import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/db/models/recipedb.dart';

class RecipeTileWidget extends StatelessWidget {
  const RecipeTileWidget({super.key, required this.data});
  final Recipe data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data.title,
      style: TextStyle(
        color: fontColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
