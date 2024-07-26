import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_app/db/models/recipedb.dart';

SizedBox imageSizedBoxRecipeDetails(Recipe recipedetails) {
  return SizedBox(
    height: 250,
    child: Image.file(File(recipedetails.image)),
  );
}
