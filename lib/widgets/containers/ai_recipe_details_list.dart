import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/db/models/response_model.dart';

Padding aiRecipeDetails(ValueNotifier<RecipeModel> aiRecipe, context) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
    child: Container(
      height: aiRecipe.value.name.isEmpty ? 400 : 1400,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: aiContainerColor,
          border: Border.all(color: aiContainerborderColor)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 30,right: 5),
        child: ValueListenableBuilder<RecipeModel>(
          valueListenable: aiRecipe,
          builder: (context, recipe, child) {
            if (recipe.name.isEmpty) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageIcon(
                    const AssetImage("assets/logos/ai.png"),
                    color: deepPurple,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Please Provide Ingredients...",
                    style: TextStyle(color: fontColor, fontSize: 18)),
                ],
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recipe.ingredients.length +
                  recipe.instructions.length +
                  recipe.tips.length +
                  5,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Text(
                    'Recipe: ${recipe.name}\n',
                    style: TextStyle(
                        color: fontColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  );
                } else if (index == 1) {
                  return Text(
                    'Serves : ${recipe.yield.isEmpty ? "2" : recipe.yield}\n',
                    style: TextStyle(color: fontColor, fontSize: 16),
                  );
                } else if (index == 2) {
                  return Text(
                    'Prep Time : ${recipe.prepTime.isEmpty ? "7" : recipe.prepTime}\n',
                    style: TextStyle(color: fontColor, fontSize: 16),
                  );
                } else if (index == 3) {
                  return Text(
                    'Cook Time : ${recipe.cookTime.isEmpty ? "20" : recipe.cookTime}\n',
                    style: TextStyle(color: fontColor, fontSize: 16),
                  );
                } else if (index == 4) {
                  return Text(
                    'Ingredients :',
                    style: TextStyle(
                        color: fontColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  );
                } else if (index < 5 + recipe.ingredients.length) {
                  return Text(
                    '- ${recipe.ingredients[index - 5]}',
                    style: TextStyle(color: fontColor, fontSize: 16),
                  );
                } else if (index == 5 + recipe.ingredients.length) {
                  return Text(
                    '\nInstructions :',
                    style: TextStyle(
                        color: fontColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  );
                } else if (index < 5 +
                        recipe.ingredients.length +
                        recipe.instructions.length) {
                  return Text(
                    '${index - 4 - recipe.ingredients.length}. ${recipe.instructions[index - 5 - recipe.ingredients.length]}',
                    style: TextStyle(color: fontColor, fontSize: 16),
                  );
                } else if (index == 5 +
                        recipe.ingredients.length +
                        recipe.instructions.length) {
                  return Text(
                    '\nTips :',
                    style: TextStyle(
                        color: fontColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  );
                } else {
                  return Text(
                      '- ${recipe.tips[index - 5 - recipe.ingredients.length - recipe.instructions.length]}',
                      style: TextStyle(color: fontColor, fontSize: 16));
                }
              },
            );
          },
        ),
      ),
    ),
  );
}
