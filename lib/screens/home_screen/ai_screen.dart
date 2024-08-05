import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_app/db/functions/ai_functions.dart';
import 'package:recipe_app/db/models/response_model.dart';
import 'package:recipe_app/widgets/bars/ai_app_bar.dart';
import 'package:recipe_app/widgets/buttons/ai_generate_button.dart';
import 'package:recipe_app/widgets/containers/ai_recipe_details_list.dart';
import 'package:recipe_app/widgets/containers/ingredient_chip_widget.dart';
import 'package:recipe_app/widgets/textfields/ai_textformfield.dart';

class AIScreen extends StatefulWidget {
  const AIScreen({super.key});

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  List<String> ingredientsList = [];
  TextEditingController ingredientsController = TextEditingController();
  bool loadingWidget = false;
  ValueNotifier<RecipeModel> aiRecipe = ValueNotifier<RecipeModel>(RecipeModel(
    name: '',
    yield: '',
    prepTime: '',
    cookTime: '',
    ingredients: [],
    instructions: [],
    tips: [],
  ));
  String responseTxt = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: aiAppBar(() {
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
      },),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            aiRecipeDetails(aiRecipe, context),
            SizedBox(height: ingredientsList.isEmpty ? 135 : 90),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: ingredientsList.map((ingredient) {
                    return ingredientChipWidget(() {
                      setState(() {
                        ingredientsList.remove(ingredient);
                      });
                    }, ingredient);
                  }).toList()),
            ),
            aiTextFormField(() {
              setState(() {
                if (ingredientsController.text.isNotEmpty) {
                  ingredientsList.add(ingredientsController.text);
                  ingredientsController.clear();
                }
              });
            }, ingredientsController),
            aiGenerateButton(() async {
              setState(() {
                loadingWidget = true;
              });
              try {
                final ingredients = ingredientsList.join(',');
                final response = await sendRequest(ingredients);

                final jsonResponse = jsonDecode(response);

                if (jsonResponse['candidates'] != null &&
                    jsonResponse['candidates'].isNotEmpty) {
                  final content = jsonResponse['candidates'][0]['content']
                      ['parts'][0]['text'];

                  setState(() {
                    responseTxt = content;
                  });

                  final recipe = parseRecipe(content);

                  aiRecipe.value = recipe;
                } else if (jsonResponse['error'] != null) {
                  log("API error");
                }
              } finally {
                setState(() {
                  loadingWidget = false;
                });
              }
            }, loadingWidget),
          ],
        ),
      ),
    );
  }
}
