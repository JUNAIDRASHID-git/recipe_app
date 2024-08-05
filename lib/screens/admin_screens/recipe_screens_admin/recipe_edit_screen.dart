import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/widgets/buttons/add_image_button.dart';
import 'package:recipe_app/widgets/buttons/drop_down_button.dart';
import 'package:recipe_app/widgets/buttons/mainbutton.dart';
import 'package:recipe_app/db/functions/db_functions/recipe_functions.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/widgets/formfields/recipe_form.dart';
import 'package:recipe_app/widgets/containers/add_image_container.dart';
import 'package:recipe_app/widgets/textfields/recipe_time_field.dart';

class UpdateRecipeadmin extends StatefulWidget {
  final Recipe recipeData;
  const UpdateRecipeadmin({super.key, required this.recipeData});

  @override
  State<UpdateRecipeadmin> createState() => _UpdateRecipeAdminState();
}

class _UpdateRecipeAdminState extends State<UpdateRecipeadmin> {
  TextEditingController _timeController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final List<TextEditingController> ingredientsController = [];
  TextEditingController _instructionController = TextEditingController();
  bool veg = true;
  File? selectedImage;
  List<String> isveg = ["VEG", "NON-VEG"];
  String selectedItem = "VEG";
  List<String> dishType = [
    "North Indian",
    "South Indian",
    "Arabic",
    "Chinese",
    "Kerala"
  ];
  String selectedDishType = "North Indian";

  @override
  void initState() {
    super.initState();
    selectedImage = File(widget.recipeData.image);
    // selectedDishType = widget.recipeData.dishType;
    _timeController =
        TextEditingController(text: widget.recipeData.time.toString());
    _titleController = TextEditingController(text: widget.recipeData.title);
    _descriptionController =
        TextEditingController(text: widget.recipeData.description);
    _instructionController =
        TextEditingController(text: widget.recipeData.instruction);
    for (var ingredient in widget.recipeData.ingrediants) {
      ingredientsController.add(TextEditingController(text: ingredient));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: fontColor, size: 35),
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.only(left: 55),
          child: Text("Update Recipe",
              style: TextStyle(color: fontColor, fontSize: 30)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(alignment: Alignment.bottomRight, children: [
              AddImageContainer(selectedImage: selectedImage),
              addImageButton(() async {
                await imagePicker();
                log("add image button pressed");
              })
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      timeFormField(timeController: _timeController),
                      dropdownButton(
                        isveg,
                        selectedItem,
                        (value) {
                          setState(() => selectedItem = value!);
                        },
                      ),
                      
                    ],
                  ),
                  const SizedBox(height: 10),
                  RecipeFormWidget(
                      titleController: _titleController,
                      descriptionController: _descriptionController,
                      instructionController: _instructionController,
                      ingredientsList: widget.recipeData.ingrediants,
                      ingredientsController: ingredientsController),
                ],
              ),
            ),
            const SizedBox(height: 50),
            MainButton(
                buttonTitle: "Update",
                buttonAction: () {
                  veg = selectedItem == "VEG";

                  final time = int.tryParse(_timeController.text) ?? 0;

                  var value = Recipe(
                      image: selectedImage!.path,
                      title: _titleController.text,
                      time: time,
                      description: _descriptionController.text,
                      ingrediants: ingredientsController
                          .map((controller) => controller.text)
                          .toList(),
                      instruction: _instructionController.text,
                      veg: veg,
                      id: widget.recipeData.id,
                      fav: false,
                      dishType: selectedDishType);

                  updateRecipe(value, widget.recipeData.id);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }

  Future<void> imagePicker() async {
    final imagePick = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (imagePick != null) {
        selectedImage = File(imagePick.path);
      }
    });
  }
}
