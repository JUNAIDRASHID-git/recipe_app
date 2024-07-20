import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';
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
  double height = 69;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldAddRecipe(
          controller: widget.titleController,
          label: 'Title',
          suffixIcon: const Icon(Icons.edit),
        ),
        sizedBox,
        TextFieldAddRecipe(
          controller: widget.descriptionController,
          label: 'Description',
          suffixIcon: const Icon(Icons.edit),
        ),
        sizedBox,
        SizedBox(
          height: height,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ingredientsController.length,
            itemBuilder: (context, index) {
              return TextFormField(
                controller: ingredientsController[index],
                style: TextStyle(color: fontColor, fontSize: 20),
                decoration: InputDecoration(
                  fillColor: textFormFieldColor,
                  filled: true,
                  suffixIcon: GestureDetector(
                      onTap: () {
                        
                        setState(() {
                          if (ingredientsController.length>1) {
                            ingredientsController[index].clear();
                            widget.ingredientsList.remove(ingredientsController[index].text);
                            ingredientsController.removeAt(index);
                            height = height - 80;
                          }else{
                            ingredientsController[index].clear();
                          }
                          
                        });
                      },
                      child: const Icon(Icons.delete)),
                  labelText: "Ingredient",
                  labelStyle: TextStyle(
                      color: fontColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(floatActionButtonColor),
                      ),
                      onPressed: () {
                        ingredientsController.add(TextEditingController());
                        if (ingredientsController[index].text.isNotEmpty) {
                          widget.ingredientsList.add(ingredientsController[index].text);
                        }
                        log('${ingredientsController.length}');
                        log('${widget.ingredientsList.length}');
                        setState(() {
                          height = height + 80;
                        });
                      },
                      icon: Icon(
                        Icons.add,
                        size: 30,
                        color: fontColor,
                      ),
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
          suffixIcon: const Icon(Icons.edit),
        ),
      ],
    );
  }
}
