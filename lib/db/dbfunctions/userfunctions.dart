import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/db/models/userdb.dart';

ValueNotifier<List<Recipe>> userRecipeNotifier = ValueNotifier([]);

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

void getAllUSers() async {
  final userDB = await Hive.openBox<User>("user_db");
  for (var element in userDB.values) {
    log(element.username);
    log(element.password);
  }
}
