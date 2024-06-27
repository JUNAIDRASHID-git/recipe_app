import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/buttons/mainbutton.dart';
import 'package:recipe_app/db/dbfunctions/recipe_functions.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/textfields/addrecipe_textfield.dart';

class AddRecipeAdmin extends StatefulWidget {
  const AddRecipeAdmin({super.key});

  @override
  State<AddRecipeAdmin> createState() => _AddRecipeAdminState();
}

class _AddRecipeAdminState extends State<AddRecipeAdmin> {
  final _timeController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredianceController = TextEditingController();
  final _instructionController = TextEditingController();
  bool veg = true;
  File? selectedImage;

  List<String> isveg = ["VEG", "NON-VEG"];
  String selectedItem = "VEG";

  @override
  void dispose() {
    _timeController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _ingredianceController.dispose();
    _instructionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(180, 75, 75, 75),
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
              Container(
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                height: 200,
                width: 370,
                child: selectedImage != null
                    ? ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        child: Image(
                            fit: BoxFit.fill, image: FileImage(selectedImage!)),
                      )
                    : const Center(
                        child: Text(
                          "ADD IMAGE",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FloatingActionButton(
                    backgroundColor: const Color.fromARGB(255, 81, 81, 81),
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
                      SizedBox(
                        height: 65,
                        width: 153,
                        child: TextFieldAddRecipe(
                          maxLines: 1,
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
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldAddRecipe(
                    maxLines: 1,
                    controller: _titleController,
                    label: 'Title',
                    prefixIcon: const Icon(Icons.edit),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldAddRecipe(
                    maxLines: 2,
                    controller: _descriptionController,
                    label: 'Description',
                    prefixIcon: const Icon(Icons.edit),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldAddRecipe(
                    maxLines: 5,
                    controller: _ingredianceController,
                    label: 'Ingrediance',
                    prefixIcon: const Icon(Icons.edit),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldAddRecipe(
                    maxLines: 5,
                    controller: _instructionController,
                    label: 'Instructions',
                    prefixIcon: const Icon(Icons.edit),
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
                  veg = selectedItem == "VEG";
                  final time = int.tryParse(_timeController.text) ?? 0;

                  var value = Recipe(
                      image: selectedImage!.path,
                      title: _titleController.text,
                      time: time,
                      description: _descriptionController.text,
                      ingrediants: _ingredianceController.text,
                      instruction: _instructionController.text,
                      veg: veg,
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      fav: false);

                  addRecipe(value);

                  Navigator.pop(context);
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
