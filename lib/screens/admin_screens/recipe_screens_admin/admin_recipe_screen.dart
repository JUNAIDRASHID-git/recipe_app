import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_app/db/dbfunctions/recipe_functions.dart';
import 'package:recipe_app/screens/admin_screens/recipe_screens_admin/recipe_add_screen.dart';
import 'package:recipe_app/screens/admin_screens/recipe_screens_admin/recipe_list_admin.dart';
import 'package:recipe_app/textfields/textfield.dart';

class AdminRecipeScreen extends StatefulWidget {
  const AdminRecipeScreen({super.key});

  @override
  State<AdminRecipeScreen> createState() => _AdminRecipeScreenState();
}

class _AdminRecipeScreenState extends State<AdminRecipeScreen> {
  final _searchController = TextEditingController();

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
        backgroundColor: const Color.fromARGB(180, 75, 75, 75),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white, size: 35),
          toolbarHeight: 80,
          backgroundColor: Colors.transparent,
          title: const Padding(
            padding: EdgeInsets.only(left: 83),
            child: Text(
              "Recipes",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFieldMain(
                  icon: const Icon(Icons.search),
                  prefixText: "Search Recipe",
                  obscuretext: false,
                  controller: _searchController),
            ),
            const Expanded(child: RecipeListAdmin()),
          ],
        ));
  }
}
