import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/db/functions/db_functions/recipe_functions.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/widgets/buttons/drop_down_button.dart';

class CatogorizeRecipeScreen extends StatefulWidget {
  const CatogorizeRecipeScreen({super.key, required this.recipeData});
  final Recipe recipeData;

  @override
  State<CatogorizeRecipeScreen> createState() => _CatogorizeRecipeScreenState();
}

class _CatogorizeRecipeScreenState extends State<CatogorizeRecipeScreen> {
  bool? northIndian = false;
  bool? southIndian = false;
  bool? chinese = false;
  bool? kerala = false;
  bool? arabic = false;
  bool veg = false;
  List<String> items = ["VEG", "NON VEG"];
  String selectedItem = "VEG";
  String dishType = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text("Select VEG/NON VEG",
                    style: TextStyle(color: fontColor, fontSize: 30)),
                dropdownButton(items, selectedItem, (value) {
                  setState(
                    () {
                      selectedItem = value!;
                    },
                  );
                }),
                Text("Select Cuzines",
                    style: TextStyle(color: fontColor, fontSize: 30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("North Indian",
                        style: TextStyle(color: fontColor, fontSize: 20)),
                    Checkbox(
                      value: northIndian,
                      activeColor: deepPurple,
                      onChanged: (value) {
                        setState(() {
                          northIndian = value;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("South Indian",
                        style: TextStyle(color: fontColor, fontSize: 20)),
                    Checkbox(
                      value: southIndian,
                      activeColor: deepPurple,
                      onChanged: (value) {
                        setState(() {
                          southIndian = value;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Chinese",
                        style: TextStyle(color: fontColor, fontSize: 20)),
                    Checkbox(
                      value: chinese,
                      activeColor: deepPurple,
                      onChanged: (value) {
                        setState(() {
                          chinese = value;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Arabic",
                        style: TextStyle(color: fontColor, fontSize: 20)),
                    Checkbox(
                      value: arabic,
                      activeColor: deepPurple,
                      onChanged: (value) {
                        setState(() {
                          arabic = value;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Kerala",
                        style: TextStyle(color: fontColor, fontSize: 20)),
                    Checkbox(
                      value: kerala,
                      activeColor: deepPurple,
                      onChanged: (value) {
                        setState(() {
                          kerala = value;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel",
                        style: TextStyle(color: fontColor, fontSize: 20))),
                TextButton(
                    onPressed: () {
                      if (northIndian == true) {
                        dishType = "North Indian";
                      } else if (southIndian == true) {
                        dishType = "South Indian";
                      } else if (chinese == true) {
                        dishType = "Chinese";
                      } else if (arabic == true) {
                        dishType = "Arabic";
                      } else if (kerala == true) {
                        dishType = "Kerala";
                      }

                      veg = selectedItem == "VEG";

                      final value = Recipe(
                          image: widget.recipeData.image,
                          title: widget.recipeData.title,
                          time: widget.recipeData.time,
                          description: widget.recipeData.description,
                          ingrediants: widget.recipeData.ingrediants,
                          instruction: widget.recipeData.instruction,
                          id: widget.recipeData.id,
                          veg: veg,
                          fav: widget.recipeData.fav,
                          dishType: dishType);

                      updateRecipe(value, widget.recipeData.id);
                      Navigator.pop(context);
                    },
                    child: Text("Submit",
                        style: TextStyle(color: fontColor, fontSize: 20))),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
