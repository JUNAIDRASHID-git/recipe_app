import 'dart:developer';

import 'package:flutter/material.dart';
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

  List<String> isveg = ["VEG", "NON-VEG"];
  String selectedItem = "VEG";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(180, 75, 75, 75),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white,size: 35),
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        title: const Padding(
          padding: EdgeInsets.only(left: 55),
          child: Text("Add Recipes",style: TextStyle(color: Colors.white,fontSize: 30),),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(alignment: Alignment.bottomRight, children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                height: 200,
                width: 370,
                child: const Center(
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
                    onPressed: () {
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
                    controller: _titleController,
                    label: 'Title',
                    prefixIcon: const Icon(Icons.edit),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldAddRecipe(
                    controller: _descriptionController,
                    label: 'Description',
                    prefixIcon: const Icon(Icons.edit),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldAddRecipe(
                    controller: _titleController,
                    label: 'Ingrediance',
                    prefixIcon: const Icon(Icons.edit),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldAddRecipe(
                    controller: _titleController,
                    label: 'Instructions',
                    prefixIcon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
