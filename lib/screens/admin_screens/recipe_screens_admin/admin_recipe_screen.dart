import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/db/functions/db_functions/recipe_functions.dart';
import 'package:recipe_app/screens/admin_screens/recipe_screens_admin/recipe_add_screen.dart';
import 'package:recipe_app/screens/admin_screens/recipe_screens_admin/recipe_list_admin.dart';

class AdminRecipeScreen extends StatefulWidget {
  const AdminRecipeScreen({super.key});

  @override
  State<AdminRecipeScreen> createState() => _AdminRecipeScreenState();
}

class _AdminRecipeScreenState extends State<AdminRecipeScreen> {

  @override
  void initState() {
    super.initState();
    getAllRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 75),
          child: FloatingActionButton(
            onPressed: () {
              log("add recipe pressed");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddRecipeAdmin()));
            },
            backgroundColor: const Color.fromARGB(255, 86, 190, 72),
            shape: const CircleBorder(),
            child: const Icon(Icons.add),
          ),
        ),
        appBar: AppBar(
          iconTheme:  IconThemeData(color: fontColor, size: 35),
          toolbarHeight: 80,
          backgroundColor: Colors.transparent,
          title:  Padding(
            padding:const EdgeInsets.only(left: 83),
            child: Text(
              "Recipes",
              style: TextStyle(color: fontColor, fontSize: 30),
            ),
          ),
        ),
        body: const RecipeListAdmin());
  }
}
