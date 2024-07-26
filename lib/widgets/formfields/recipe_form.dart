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
    required this.ingredientsList, required this.ingredientsController,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final List<String> ingredientsList;
  final TextEditingController instructionController;
  final List<TextEditingController> ingredientsController;

  @override
  State<RecipeFormWidget> createState() => _RecipeFormWidgetState();
}

class _RecipeFormWidgetState extends State<RecipeFormWidget> {
  Widget sizedBox = const SizedBox(height: 10);
  double height = 69;
@override
  void initState() {
    
    super.initState();
    if(widget.ingredientsController.length>1){
      height = widget.ingredientsController.length * 79;
    }
  }
  @override
  Widget build(BuildContext context) {
    log("${widget.ingredientsController.length}");
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
            itemCount: widget.ingredientsController.length,
            itemBuilder: (context, index) {
              return TextFormField(
                controller: widget.ingredientsController[index],
                style: TextStyle(color: fontColor, fontSize: 20),
                decoration: InputDecoration(
                  fillColor: textFormFieldColor,
                  filled: true,
                  suffixIcon: GestureDetector(
                      onTap: () {
                        
                        setState(() {
                          if (widget.ingredientsController.length>1) {
                           widget. ingredientsController[index].clear();
                            widget.ingredientsList.remove(widget.ingredientsController[index].text);
                            widget.ingredientsController.removeAt(index);
                            height = height - 80;
                          }else{
                            widget.ingredientsController[index].clear();
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
                       widget.ingredientsController.add(TextEditingController());
                        if (widget.ingredientsController[index].text.isNotEmpty) {
                          widget.ingredientsList.add(widget.ingredientsController[index].text);
                        }
                        log('${widget.ingredientsController.length}');
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
