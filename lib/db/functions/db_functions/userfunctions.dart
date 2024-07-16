import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/db/models/userdb.dart';

ValueNotifier<List<Recipe>> userRecipeNotifier = ValueNotifier([]);
ValueNotifier<List<Recipe>> userFavRecipeNotifier = ValueNotifier([]);

void addUser({
  required String email,
  required String username,
  required String password,
  required String id,
}) async {
  final userDB = await Hive.openBox<User>("user_db");
  final newUser = User(
    email: email,
    username: username,
    password: password,
    id: id,
  );
  await userDB.put(id, newUser);
  log(id);
  log(newUser.username);
  log(newUser.password);
}

void addUserRecipe({required id, required User value}) async {
  final userDB = await Hive.openBox<User>("user_db");
  userDB.put(id, value);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  userRecipeNotifier.notifyListeners;
}

void getUser({required id}) async {
  final userDB = await Hive.openBox<User>("user_db");
  userRecipeNotifier.value.clear();
  final user = userDB.get(id);
  user!.userRecipe?.forEach(
    (element) {
      userRecipeNotifier.value.add(element);
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      userRecipeNotifier.notifyListeners;
    },
  );
}

void getUserFav({required String id}) async {
  userFavRecipeNotifier.value.clear();
  final userDB = await Hive.openBox<User>("user_db");

  final user = userDB.get(id);

  if (user != null && user.favorite != null) {
    // Use a Set to avoid duplicates
    final Set<String> seenRecipeIds = {};
    for (var element in user.favorite!) {
      if (seenRecipeIds.add(element.id)) {
        userFavRecipeNotifier.value.add(element);
      }
    }
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    userFavRecipeNotifier.notifyListeners();
  }
}

void getAllUSers() async {
  final userDB = await Hive.openBox<User>("user_db");
  for (var element in userDB.values) {
    log(element.username);
    log(element.password);
  }
}

void deleteUserRecipe(String id, int index) async {
  final recipeDB = await Hive.openBox<User>("user_db");
  final user = recipeDB.get(id);
  final userRecipe = user!.userRecipe;
  userRecipe!.removeAt(index);
  userRecipeNotifier.value.removeAt(index);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  userRecipeNotifier.notifyListeners;
}

void deleteUserFavRecipe(String id, int index) async {
  final users = await Hive.openBox<User>("user_db");
  final user = users.get(id);

  final userFavRecipe = user!.favorite;
  userFavRecipe!.removeAt(index);
  userFavRecipeNotifier.value.removeAt(index);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  userFavRecipeNotifier.notifyListeners();
}
