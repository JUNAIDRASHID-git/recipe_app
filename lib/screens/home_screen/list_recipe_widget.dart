import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';
import 'package:recipe_app/db/functions/db_functions/recipe_functions.dart';
import 'package:recipe_app/db/functions/db_functions/userfunctions.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/screens/home_screen/recipe_details_screen.dart';
import 'package:recipe_app/widgets/containers/image_widget_container.dart';
import 'package:recipe_app/widgets/containers/time_widget_container.dart';
import 'package:recipe_app/widgets/containers/veg_widget_container.dart';
import 'package:recipe_app/widgets/text_widgets/recipe_description_widget.dart';
import 'package:recipe_app/widgets/text_widgets/recipe_title_widget.dart';

class ListRecipe extends StatefulWidget {
  const ListRecipe({super.key, required this.userdetails});
  final User userdetails;

  @override
  
  // ignore: library_private_types_in_public_api
  _ListRecipeState createState() => _ListRecipeState();
}

class _ListRecipeState extends State<ListRecipe> {
  final TextEditingController _searchController = TextEditingController();
  List<Recipe> filteredRecipes = [];
  List<Recipe> favorite = [];

  bool? isLiked;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterRecipes);
    if(widget.userdetails.favorite!=null){
      favorite = widget.userdetails.favorite!;
    }
  }

  void _filterRecipes() {
    setState(() {
      filteredRecipes = recipeNotifier.value
          .where((recipe) => recipe.title.toLowerCase()
          .contains(_searchController.text.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return ValueListenableBuilder(
      valueListenable: recipeNotifier,
      builder: (BuildContext context, List<Recipe> recipeList, Widget? child) {
        filteredRecipes =
            filteredRecipes.isEmpty && _searchController.text.isEmpty ? recipeList: filteredRecipes;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  isDense: true,
                  fillColor: Color.fromARGB(255, 231, 231, 231),
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  hintText: 'Search Recipes...',
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final data = filteredRecipes[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetailScreen(recipedetails: data),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: recipeContainerColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                        ),
                        width: 80,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    RecipeTileWidget(data: data),
                                    LikeButton(
                                      size: 55,
                                      bubblesSize: 90,
                                      bubblesColor: BubblesColor(
                                          dotPrimaryColor: favoriteColor,
                                          dotSecondaryColor: favoriteColor),
                                      likeBuilder: (bool isLiked) {
                                        return Icon(
                                          Icons.star_rounded,
                                          size: 55,
                                          color: isLiked ? favoriteColor : fontColor,
                                        );
                                      },
                                      onTap: (bool isLiked) async {
                                        
                                        
                                        bool fav = false;
                                        final recipe = Recipe(
                                          image: data.image,
                                          title: data.title,
                                          time: data.time,
                                          description: data.description,
                                          ingrediants: data.ingrediants,
                                          instruction: data.instruction,
                                          id: data.id,
                                          veg: data.veg,
                                          fav: fav,
                                        );
                                        if (!isLiked) {
                                          fav = true;
                                          favorite.add(recipe);
                                          favorite.toSet().toList();
                                          log("${favorite.length}");
                                        } else {
                                          fav = false;
                                          favorite.removeWhere((recipe) => recipe.id == data.id);
                                          log("${favorite.length}");
                                        }
                                        final updatedUser = User(
                                          email: widget.userdetails.email,
                                          username: widget.userdetails.username,
                                          password: widget.userdetails.password,
                                          id: widget.userdetails.id,
                                          favorite: favorite,
                                        );

                                        addUserRecipe(id: widget.userdetails.id, value: updatedUser);
                                        getUserFav(id: widget.userdetails.id);
                                        log(isLiked ? "Disliked" : "Liked");

                                        return !isLiked;
                                      },
                                    )
                                  ],
                                ),
                              ),
                              ImageWidgetContainer(data: data),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
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
            ),
          ],
        );
      },
    );
  }
}
