import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';
import 'package:recipe_app/db/functions/db_functions/userfunctions.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/screens/user_screen/saved_recipes_screeen.dart';
import 'package:recipe_app/widgets/buttons/mainbutton.dart';
import 'package:recipe_app/widgets/containers/add_image_container.dart';
import 'package:recipe_app/widgets/formfields/recipe_form.dart';
import 'package:recipe_app/widgets/textfields/recipe_time_field.dart';

class UserRecipeEditScreen extends StatefulWidget {
  final Recipe recipeData;
  final User userData;
  final int index;
  const UserRecipeEditScreen(
      {super.key,
      required this.recipeData,
      required this.userData,
      required this.index});

  @override
  State<UserRecipeEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserRecipeEditScreen> {
  TextEditingController _timeController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final List<String> _ingredianceController = [];
  TextEditingController _instructionController = TextEditingController();
  bool veg = true;
  File? selectedImage;
  List<String> isveg = ["VEG", "NON-VEG"];
  String selectedItem = "VEG";

  @override
  void initState() {
    userRecipeNotifier;
    super.initState();
    selectedImage = File(widget.recipeData.image);
    _timeController =
        TextEditingController(text: widget.recipeData.time.toString());
    _titleController = TextEditingController(text: widget.recipeData.title);
    _descriptionController =
        TextEditingController(text: widget.recipeData.description);
    // incrediance
    _instructionController =
        TextEditingController(text: widget.recipeData.instruction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
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
                  const SizedBox(height: 10),
                  RecipeFormWidget(
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                    instructionController: _instructionController,
                    ingredientsList: _ingredianceController,
                  )
                ],
              ),
            ),
            const SizedBox(height: 50),
            MainButton(
                buttonTitle: "Update",
                buttonAction: () async {
                  veg = selectedItem == "VEG";

                  final time = int.tryParse(_timeController.text) ?? 0;

                  widget.userData.userRecipe!.remove(widget.recipeData);
                  List<Recipe> recipeList = [...widget.userData.userRecipe!];

                  
                  
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
                      email: widget.userData.email,
                      username: widget.userData.username,
                      password: widget.userData.password,
                      id: widget.userData.id,
                      userRecipe: recipeList);

                  log("${recipeList.length}");

                  
                  addUserRecipe(id: widget.userData.id, value: userValue);
                  getUser(id: widget.userData.id);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UserSavedRecipes(userdetails: userValue)));
                })
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
