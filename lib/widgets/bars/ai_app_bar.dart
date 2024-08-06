import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/db/models/response_model.dart';

AppBar aiAppBar(setState,List<String>ingredientsList,String responseTxt,aiRecipe) {
  return AppBar(
    actions: [
      ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(deepPurple),
          ),
          onPressed: () {
        setState(() {
        ingredientsList.clear();
        responseTxt = "";
        });
      aiRecipe.value= RecipeModel(
    name: '',
    yield: '',
    prepTime: '',
    cookTime: '',
    ingredients: [],
    instructions: [],
    tips: [],
  );
      },
          child:Text("Clear All",style: TextStyle(color: fontColor),)),
          const Text("   ")
        
    ],
    leading: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ImageIcon(
          const AssetImage("assets/logos/ai.png"),
          color: deepPurple,
        ),
      ],
    ),
    title: ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [deepPurple, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      child: Text(
        "AI CHEF",
        style: TextStyle(color: fontColor),
      ),
    ),
    backgroundColor: mainbgcolor,
  );
}
