import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';
import 'package:recipe_app/db/dbfunctions/recipe_functions.dart';
import 'package:recipe_app/db/dbfunctions/userfunctions.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/widgets/buttons/user_add_recipe_buttons.dart';
import 'package:recipe_app/widgets/containers/add_image_container.dart';
import 'package:recipe_app/widgets/formfields/recipe_form.dart';
import 'package:recipe_app/widgets/textfields/recipe_time_field.dart';

class UserRecipeAddScreen extends StatefulWidget {
  const UserRecipeAddScreen({super.key, required this.userdetails});
  final User userdetails;

  @override
  State<UserRecipeAddScreen> createState() => _UserRecipeAddScreenState();
}

class _UserRecipeAddScreenState extends State<UserRecipeAddScreen> {
  final _timeController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<String> _ingredianceController = [];
  final _instructionController = TextEditingController();
  bool veg = true;
  File? selectedImage;
  Widget sizedBox = const SizedBox(height: 10);
  List<String> isveg = ["VEG", "NON-VEG"];
  String selectedItem = "VEG";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainbgcolor,
      appBar: AppBar(
        leading: const Text(""),
        backgroundColor: Colors.transparent,
        toolbarHeight: 75,
        title: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Text(
            "Add Your Recipe",
            style:
                TextStyle(color: fontColor, fontSize: 40, fontFamily: "Oswald"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(alignment: Alignment.bottomRight, children: [
              AddImageContainer(selectedImage: selectedImage),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FloatingActionButton(
                    backgroundColor: const Color.fromARGB(255, 81, 81, 81),
                    child: const Icon(Icons.add_a_photo_outlined,
                        color: Colors.white),
                    onPressed: () async {
                      await imagePicker();
                      log("add image button pressed");
                    }),
              )
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            style: TextStyle(
                                color: fontColor,
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
                    ingredientsList: [..._ingredianceController],
                  )
                ],
              ),
            ),
            sizedBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  UserAddRecipeButton(
                    buttonTitle: "Publish",
                    buttonAction: () {
                      veg = selectedItem == "VEG";
                      final time = int.tryParse(_timeController.text) ?? 0;
                      final value = Recipe(
                        image: selectedImage!.path,
                        title: _titleController.text,
                        time: time,
                        description: _descriptionController.text,
                        instruction: _instructionController.text,
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        veg: veg,
                        fav: false,
                        ingrediants:_ingredianceController,
                      );
                      addRecipe(value);
                      setState(() {
                        clearField();
                      });
                      log("save draft pressed");
                    },
                  ),
                  UserAddRecipeButton(
                    buttonTitle: "SAVE",
                    buttonAction: () {
                      veg = selectedItem == "VEG";
                      final time = int.tryParse(_timeController.text) ?? 0;

                      List<Recipe> recipeList = [
                        ...widget.userdetails.userRecipe ?? []
                      ];

                      var recipe = Recipe(
                          image: selectedImage!.path,
                          title: _titleController.text,
                          time: time,
                          description: _descriptionController.text,
                          ingrediants: _ingredianceController,
                          instruction: _instructionController.text,
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          veg: veg,
                          fav: false);

                      recipeList.add(recipe);

                      final userValue = User(
                          email: widget.userdetails.email,
                          username: widget.userdetails.username,
                          password: widget.userdetails.password,
                          id: widget.userdetails.id,
                          userRecipe: recipeList);

                      addUserRecipe(
                          id: widget.userdetails.id, value: userValue);
                      log("${userValue.userRecipe}");
                      log("save draft pressed");
                      setState(() {
                        clearField();
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70)
          ],
        ),
      ),
    );
  }

  void clearField() {
    _titleController.clear();
    _descriptionController.clear();
    _ingredianceController.clear();
    _instructionController.clear();
    _timeController.clear();
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
