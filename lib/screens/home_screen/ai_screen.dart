import 'package:flutter/material.dart';
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
  ValueNotifier<RecipeModel> aiRecipe = ValueNotifier<RecipeModel>(RecipeModel(
      name: '',
      yield: '',
      prepTime: '',
      cookTime: '',
      ingredients: [],
      instructions: [],
      tips: []));
  String responseTxt = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: aiAppBar(setState, ingredientsList, responseTxt, aiRecipe),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            aiRecipeDetails(aiRecipe, context),
            SizedBox(height: ingredientsList.isEmpty ? 135 : 90),
            ingredientBox(ingredientsList, setState),
            aiTextFormField(ingredientsController, ingredientsList, setState),
            aiGenerateButton(setState, ingredientsList, responseTxt, aiRecipe),
          ],
        ),
      ),
    );
  }
}
