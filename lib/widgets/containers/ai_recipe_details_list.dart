import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/db/models/response_model.dart';

Padding aiRecipeDetails(ValueNotifier<RecipeModel> aiRecipe,context) {
    return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ValueListenableBuilder<RecipeModel>(
              valueListenable: aiRecipe,
              builder: (context, recipe, child) {
                if (recipe.name.isEmpty) {
                  return Text(
                    "No recipe generated yet.",
                    style: TextStyle(color: fontColor, fontSize: 18),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recipe.ingredients.length + recipe.instructions.length + recipe.tips.length + 5,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Text(
                        'Recipe: ${recipe.name}\n',
                        style: TextStyle(color: fontColor, fontSize: 28, fontWeight: FontWeight.bold),
                      );
                    } else if (index == 1) {
                      return Text(
                        'Yield: ${recipe.yield}\n',
                        style: TextStyle(color: fontColor, fontSize: 16),
                      );
                    } else if (index == 2) {
                      return Text(
                        'Prep Time: ${recipe.prepTime}\n',
                        style: TextStyle(color: fontColor, fontSize: 16),
                      );
                    } else if (index == 3) {
                      return Text(
                        'Cook Time: ${recipe.cookTime}\n',
                        style: TextStyle(color: fontColor, fontSize: 16),
                      );
                    } else if (index == 4) {
                      return Text(
                        'Ingredients:',
                        style: TextStyle(color: fontColor, fontSize: 20, fontWeight: FontWeight.bold),
                      );
                    } else if (index < 5 + recipe.ingredients.length) {
                      return Text(
                        '- ${recipe.ingredients[index - 5]}',
                        style: TextStyle(color: fontColor, fontSize: 16),
                      );
                    } else if (index == 5 + recipe.ingredients.length) {
                      return Text(
                        '\nInstructions:',
                        style: TextStyle(color: fontColor, fontSize: 18, fontWeight: FontWeight.bold),
                      );
                    } else if (index < 5 + recipe.ingredients.length + recipe.instructions.length) {
                      return Text(
                        '${index - 4 - recipe.ingredients.length}. ${recipe.instructions[index - 5 - recipe.ingredients.length]}',
                        style: TextStyle(color: fontColor, fontSize: 16),
                      );
                    } else if (index == 5 + recipe.ingredients.length + recipe.instructions.length) {
                      return Text(
                        '\nTips:',
                        style: TextStyle(color: fontColor, fontSize: 18, fontWeight: FontWeight.bold),
                      );
                    } else {
                      return Text(
                        '- ${recipe.tips[index - 5 - recipe.ingredients.length - recipe.instructions.length]}',
                        style: TextStyle(color: fontColor, fontSize: 16),
                      );
                    }
                  },
                );
              },
            ),
          );
  }