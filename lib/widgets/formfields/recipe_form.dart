import 'package:flutter/material.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';
import 'package:recipe_app/widgets/textfields/addrecipe_textfield.dart';

class RecipeFormWidget extends StatefulWidget {
  const RecipeFormWidget({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.instructionController,
    required this.ingredientsList,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final List<String> ingredientsList;
  final TextEditingController instructionController;

  @override
  State<RecipeFormWidget> createState() => _RecipeFormWidgetState();
}

class _RecipeFormWidgetState extends State<RecipeFormWidget> {
  Widget sizedBox = const SizedBox(height: 10);
  List<TextEditingController> ingredientsController = [TextEditingController()];
  double height = 63;

  @override
  void dispose() {
    widget.titleController.dispose();
    widget.descriptionController.dispose();
    widget.instructionController.dispose();
    for (var controller in ingredientsController) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldAddRecipe(
          controller: widget.titleController,
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
        SizedBox(
          height: height,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ingredientsController.length,
            itemBuilder: (context, index) {
              return TextFormField(
                scribbleEnabled: true,
                controller: ingredientsController[index],
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  filled: true,
                  prefixIcon: const Icon(Icons.edit),
                  labelText: "Ingredient",
                  labelStyle: TextStyle(
                      color: fontColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        ingredientsController.add(TextEditingController());
                        widget.ingredientsList
                            .add(ingredientsController[index].text);
                        height = height + 75;
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      size: 30,
                      color: fontColor,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
          ),
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
