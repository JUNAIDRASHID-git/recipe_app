import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/db/functions/db_functions/recipe_functions.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/screens/home_screen/recipe_details_screen.dart';
import 'package:recipe_app/widgets/buttons/drop_down_button.dart';
import 'package:recipe_app/widgets/buttons/favorite_button.dart';
import 'package:recipe_app/widgets/containers/image_widget_container.dart';
import 'package:recipe_app/widgets/containers/time_widget_container.dart';
import 'package:recipe_app/widgets/containers/veg_widget_container.dart';
import 'package:recipe_app/widgets/text_widgets/emptylist_text_message_widget.dart';
import 'package:recipe_app/widgets/text_widgets/recipe_description_widget.dart';
import 'package:recipe_app/widgets/text_widgets/recipe_title_widget.dart';
import 'package:recipe_app/widgets/textfields/searchfield.dart';

class ListRecipe extends StatefulWidget {
  const ListRecipe({super.key, required this.userdetails});
  final User userdetails;

  @override
  // ignore: library_private_types_in_public_api
  _ListRecipeState createState() => _ListRecipeState();
}

class _ListRecipeState extends State<ListRecipe> {
  final TextEditingController searchController = TextEditingController();
  List<Recipe> filteredRecipes = [];
  List<Recipe> favorite = [];
  List<String> isveg = ["VEG", "NON-VEG", "Default"];
  String selectedItem = "Default";
  List<String> time = ["< 15 Min", "< 30 Min", "Default"];
  String selectedTime = "Default";
  List<String> dishType = ["North Indian", "South Indian", "Arabic","Chinese","Kerala","Default"];
  String selectedDishType = "Default";
  bool? isLiked;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterRecipes);
    if (widget.userdetails.favorite != null) {
      favorite = widget.userdetails.favorite!;
    }
   
  }

  void _filterRecipes() {
    setState(() {
      filteredRecipes = recipeNotifier.value.where((recipe) {
        final matchesSearch = recipe.title
            .toLowerCase()
            .contains(searchController.text.toLowerCase());

        final matchesVeg = selectedItem == "Default" ||
            (selectedItem == "VEG" && recipe.veg) ||
            (selectedItem == "NON-VEG" && !recipe.veg);

        final matchesTime = selectedTime == "Default" ||
            (selectedTime == "< 15 Min" && recipe.time <= 15) ||
            (selectedTime == "< 30 Min" && recipe.time <= 30);

        final matchesDishType = selectedDishType == "Default" ||
          recipe.dishType == selectedDishType;

        return matchesSearch && matchesVeg && matchesTime && matchesDishType;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: recipeNotifier,
      builder: (BuildContext context, List<Recipe> recipeList, Widget? child) {
        filteredRecipes =
            filteredRecipes.isEmpty && searchController.text.isEmpty
                ? recipeList
                : filteredRecipes;
        return Column(
          children: [
            searchTextField(searchController),
            filterHeading(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 40),
                dropdownButton(
                  dishType,
                  selectedDishType,
                  (value) {
                    setState(() => selectedDishType = value!);
                    _filterRecipes();
                    const SizedBox.shrink();
                  },
                ),
                const SizedBox(width: 10),
                 dropdownButton(
                  isveg,
                  selectedItem,
                  (value) {
                    setState(() => selectedItem = value!);
                    _filterRecipes();
                    const SizedBox.shrink();
                  },
                ),
                const SizedBox(width: 10),
                dropdownButton(
                  time,
                  selectedTime,
                  (value) {
                    setState(() => selectedTime = value!);
                    _filterRecipes();
                    const SizedBox.shrink();
                  },
                ),
              ],
            ),
            const SizedBox(height: 13),
            filteredRecipes.isEmpty
                ? emptyTextMessage()
                : Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final data = filteredRecipes[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RecipeDetailScreen(
                                  recipedetails: data,
                                  userdetails: widget.userdetails,
                                  favorite: favorite,
                                ),
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: recipeContainerColor,
                                borderRadius:const BorderRadius.all(Radius.circular(40)),
                              ),
                              width: 80,
                              child: Padding(
                                padding:const EdgeInsets.symmetric(horizontal: 25),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Row(
                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                        children: [
                                          RecipeTileWidget(data: data),
                                          favButton(
                                              data: data,
                                              favorite: favorite,
                                              userData: widget.userdetails)
                                        ],
                                      ),
                                    ),
                                    ImageWidgetContainer(data: data),
                                    Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              VegWidgetContainer(data: data),
                                              TimeWidgetContainer(data: data)
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                            child: RecipeDescriptionWidget(data: data)),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 20),
                      itemCount: filteredRecipes.length,
                    ),
                  )
          ],
        );
      },
    );
  }

  Padding filterHeading() {
    return Padding(
            padding: const EdgeInsets.only(left: 50, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Filter",
                  style: TextStyle(
                      fontSize: 25,
                      color: fontColor,
                      fontFamily: "Oswald",
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
  }
}
