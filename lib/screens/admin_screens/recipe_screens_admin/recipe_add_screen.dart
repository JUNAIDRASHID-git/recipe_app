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

class AddRecipeAdmin extends StatefulWidget {
  const AddRecipeAdmin({super.key});

  @override
  State<AddRecipeAdmin> createState() => _AddRecipeAdminState();
}

class _AddRecipeAdminState extends State<AddRecipeAdmin> {
  final _timeController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<String> _ingredianceController = [];
  List<TextEditingController> ingredientsController = [TextEditingController()];
  final _instructionController = TextEditingController();
  bool veg = true;
  File? selectedImage;
  Widget sizedBox = const SizedBox(
    height: 10,
  );

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
    _ingredianceController.clear();
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
          child: Text(
            "Add Recipes",
            style: TextStyle(color: fontColor, fontSize: 30),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(alignment: Alignment.bottomRight, children: [
              AddImageContainer(
                selectedImage: selectedImage,
              ),
              addImageButton(() async {
                await imagePicker();
                log("add image button pressed");
              })
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
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
                  sizedBox,
                  RecipeFormWidget(
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                    instructionController: _instructionController,
                    ingredientsList: _ingredianceController,
                    ingredientsController: ingredientsController,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            MainButton(
                buttonTitle: "Save",
                buttonAction: () {
                  if (selectedImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select an image"),
                      ),
                    );
                    return;
                  }

                  veg = selectedItem == "VEG";
                  final time = int.tryParse(_timeController.text) ?? 0;

                  var value = Recipe(
                      image: selectedImage!.path,
                      title: _titleController.text,
                      time: time,
                      description: _descriptionController.text,
                      ingrediants: _ingredianceController,
                      instruction: _instructionController.text,
                      veg: veg,
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      dishType: selectedDishType,
                      fav: false);

                  addRecipe(value);
                  log("${_ingredianceController.length}");
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }

  Future<void> imagePicker() async {
    final imagePick =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (imagePick != null) {
        selectedImage = File(imagePick.path);
      }
    });
  }
}
