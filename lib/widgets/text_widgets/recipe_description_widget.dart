import 'package:flutter/material.dart';
import 'package:recipe_app/db/models/recipedb.dart';

class RecipeDescriptionWidget extends StatelessWidget {
  const RecipeDescriptionWidget({super.key, required this.data});
  final Recipe data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data.description,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    );
  }
}
