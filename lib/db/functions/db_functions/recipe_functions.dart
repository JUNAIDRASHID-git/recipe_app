import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/db/models/recipedb.dart';

ValueNotifier<List<Recipe>> recipeNotifier = ValueNotifier([]);

void addRecipe(Recipe value) async {
  final recipeDB = await Hive.openBox<Recipe>("recipe_db");
  final newRecipe = value;
  await recipeDB.put(newRecipe.id, newRecipe);
  recipeNotifier.value.add(value);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  recipeNotifier.notifyListeners();
  log("${newRecipe.ingrediants.length}");
}

void getAllRecipes() async {
  final recipeDB = await Hive.openBox<Recipe>("recipe_db");
  recipeNotifier.value.clear();
  recipeNotifier.value.addAll(recipeDB.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  recipeNotifier.notifyListeners();
}

void deleteRecipe(String id) async {
  final recipeDB = await Hive.openBox<Recipe>("recipe_db");
  await recipeDB.delete(id);
  getAllRecipes();
}

Future<void> updateRecipe(Recipe value) async {
  final recipeDB = await Hive.openBox<Recipe>("recipe_db");
  final newRecipe = value;
  await recipeDB.put(newRecipe.id, newRecipe);
  getAllRecipes();
}
