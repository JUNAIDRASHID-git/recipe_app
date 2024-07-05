import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/textfields/addrecipe_textfield.dart';

class RecipeFormWidget extends StatefulWidget {
  const RecipeFormWidget({super.key, required this.titleController, required this.descriptionController, required this.ingredianceController, required this.instructionController});
 final TextEditingController titleController;
 final TextEditingController descriptionController;
 final TextEditingController ingredianceController;
 final TextEditingController instructionController;

  @override
  State<RecipeFormWidget> createState() => _RecipeFormWidgetState();
}

class _RecipeFormWidgetState extends State<RecipeFormWidget> {
  Widget sizedBox = const SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    return Column(
                    children: [
                      TextFieldAddRecipe(
                    controller:widget.titleController,
                    label: 'Title',
                    prefixIcon: const Icon(Icons.edit),
                  ),
                  sizedBox,
                  TextFieldAddRecipe(
                    controller: widget.descriptionController,
                    label: 'Description',
                    prefixIcon: const Icon(Icons.edit),
                  ),
                  sizedBox,
                  TextFieldAddRecipe(
                    controller: widget.ingredianceController,
                    label: 'Ingredients',
                    prefixIcon: const Icon(Icons.edit),
                  ),
                  sizedBox,
                  TextFieldAddRecipe(
                    controller: widget.instructionController,
                    label: 'Instructions',
                    prefixIcon: const Icon(Icons.edit),
                  ),
                    ],
                  );
  }
}