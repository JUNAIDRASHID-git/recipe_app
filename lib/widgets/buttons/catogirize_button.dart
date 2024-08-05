import 'package:flutter/material.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/screens/admin_screens/recipe_screens_admin/catogorize_screen.dart';


ElevatedButton catogorizeButton(BuildContext context,Recipe data) {
    return ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CatogorizeRecipeScreen(recipeData: data,),));
                },
            child: const Text("Catogorize"),
          );
  }