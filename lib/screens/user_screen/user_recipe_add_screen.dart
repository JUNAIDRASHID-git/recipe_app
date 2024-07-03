import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';
import 'package:recipe_app/db/dbfunctions/recipe_functions.dart';
import 'package:recipe_app/db/dbfunctions/userfunctions.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/widgets/containers/add_image_container.dart';
import 'package:recipe_app/widgets/buttons/mainbutton.dart';
import 'package:recipe_app/widgets/textfields/addrecipe_textfield.dart';

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
  final _ingredianceController = TextEditingController();
  final _instructionController = TextEditingController();
  bool veg = true;
  File? selectedImage;
  Widget sizedBox = const SizedBox(height: 10);
  List<String> isveg = ["VEG", "NON-VEG"];
  String selectedItem = "VEG";
  @override
  void dispose() {
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainbgcolor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              leading: Text(""),
              backgroundColor: Colors.transparent,
              title: Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  "Add Your Recipe",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            )
          ];
        },
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 65,
                          width: 153,
                          child: TextFieldAddRecipe(
                            keyboardType: TextInputType.number,
                            controller: _timeController,
                            label: 'Time',
                            prefixIcon: const Icon(Icons.edit),
                          ),
                        ),
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
                    TextFieldAddRecipe(
                      controller: _titleController,
                      label: 'Title',
                      prefixIcon: const Icon(Icons.edit),
                    ),
                    sizedBox,
                    TextFieldAddRecipe(
                      controller: _descriptionController,
                      label: 'Description',
                      prefixIcon: const Icon(Icons.edit),
                    ),
                    sizedBox,
                    TextFieldAddRecipe(
                      controller: _ingredianceController,
                      label: 'Ingredients',
                      prefixIcon: const Icon(Icons.edit),
                    ),
                    sizedBox,
                    TextFieldAddRecipe(
                      controller: _instructionController,
                      label: 'Instructions',
                      prefixIcon: const Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              MainButton(
                buttonTitle: "Publish",
                buttonAction: () {
                  final time = int.tryParse(_timeController.text) ?? 0;
                  final value = Recipe(
                      image: selectedImage!.path,
                      title: _titleController.text,
                      time: time,
                      description: _descriptionController.text,
                      ingrediants: _ingredianceController.text,
                      instruction: _instructionController.text,
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      veg: veg,
                      fav: false);
                  addRecipe(value);
                },
              ),
              MainButton(
                buttonTitle: "Save to Draft",
                buttonAction: () {
                  final time = int.tryParse(_timeController.text) ?? 0;
                  List<Recipe> recipeList = List.from(widget.userdetails.userRecipe as Iterable);
                  
                  recipeList.add( Recipe(
                      image: selectedImage!.path,
                      title: _titleController.text,
                      time: time,
                      description: _descriptionController.text,
                      ingrediants: _ingredianceController.text,
                      instruction: _instructionController.text,
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      veg: veg,
                      fav: false));
                  

                  final userValue = User(
                      email: widget.userdetails.email,
                      username: widget.userdetails.username,
                      password: widget.userdetails.password,
                      id: widget.userdetails.id,
                      userRecipe: recipeList);

                  addUserRecipe(id: widget.userdetails.id, value: userValue);
                  log("${userValue.userRecipe}");
                  log("save draft pressed");
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
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
