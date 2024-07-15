import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';
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
  final _instructionController = TextEditingController();
  bool veg = true;
  File? selectedImage;
  Widget sizedBox = const SizedBox(
    height: 10,
  );

  List<String> isveg = ["VEG", "NON-VEG"];
  String selectedItem = "VEG";


  @override
  void initState() {
    super.initState();
    _ingredianceController.clear();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        title: const Padding(
          padding: EdgeInsets.only(left: 55),
          child: Text(
            "Add Recipes",
            style: TextStyle(color: Colors.white, fontSize: 30),
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FloatingActionButton(
                    backgroundColor: floatActionButtonColor,
                    child: const Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await imagePicker();
                      log("add image button pressed");
                    }),
              )
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                            dropdownColor: Colors.grey,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            value: selectedItem,
                            items: isveg.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) =>
                                setState(() => selectedItem = value!),
                            underline: const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  sizedBox,
                  RecipeFormWidget(
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                    instructionController: _instructionController,
                    ingredientsList: _ingredianceController,
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
