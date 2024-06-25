import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/db/default_db/default_recipes.dart';
import 'package:recipe_app/db/models/recipedb.dart';

ValueNotifier<List<Recipe>> recipeNotifier = ValueNotifier([]);

void addRecipe(Recipe value) async {
  final recipeDB = await Hive.openBox<Recipe>("recipe_db");
  await recipeDB.add(value);
  recipeNotifier.value.add(value);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  recipeNotifier.notifyListeners();
}

void getAllRecipes()async{
  final recipeDB = await Hive.openBox<Recipe>("recipe_db");
  recipeNotifier.value.clear();
  recipeNotifier.value.addAll(defaultRecipes);
  recipeNotifier.value.addAll(recipeDB.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  recipeNotifier.notifyListeners();
}