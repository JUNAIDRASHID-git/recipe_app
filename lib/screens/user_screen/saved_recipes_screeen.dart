import 'package:flutter/material.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';
import 'package:recipe_app/db/dbfunctions/userfunctions.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/screens/home_screen/recipe_details_screen.dart';
import 'package:recipe_app/widgets/buttons/edit_delete_button.dart';
import 'package:recipe_app/widgets/containers/image_widget_container.dart';
import 'package:recipe_app/widgets/containers/time_widget_container.dart';
import 'package:recipe_app/widgets/containers/veg_widget_container.dart';
import 'package:recipe_app/widgets/text_widgets/recipe_description_widget.dart';
import 'package:recipe_app/widgets/text_widgets/recipe_title_widget.dart';
import 'package:recipe_app/widgets/text_widgets/screen_appbar_heading_title.dart';

class UserSavedRecipes extends StatefulWidget {
  const UserSavedRecipes({super.key, required this.userdetails});
  final User userdetails;

  @override
  State<UserSavedRecipes> createState() => _UserSavedRecipesState();
}

class _UserSavedRecipesState extends State<UserSavedRecipes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainbgcolor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        title: const Padding(
            padding: EdgeInsets.only(left: 45),
            child: ScreenTitleHeading(title: "Saved Recipes")),
      ),
      body: ValueListenableBuilder(
        valueListenable: userRecipeNotifier,
        builder:(BuildContext context, List<Recipe> userRecipeList, Widget? child) {
          return userRecipeList.isEmpty
              ? const Center(
                  child: Text(
                    "No Recipes are Saved",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final data = userRecipeList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(40)),
                                ),
                                width: 80,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RecipeTileWidget(data: data),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                data.fav = !data.fav;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.star_rounded,
                                              size: 55,
                                              color: data.fav == true
                                                  ? Colors.yellow
                                                  : Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      ImageWidgetContainer(
                                        data: data,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                VegWidgetContainer(data: data),
                                                TimeWidgetContainer(data: data),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 5),
                                            child: RecipeDescriptionWidget(
                                                data: data),
                                          ),
                                          DeleteEditButton(
                                            buttonAction: () {
                                              setState(() {
                                                deleteUserRecipe(
                                                  widget.userdetails.id, data);
                                              });
                                            },
                                            buttonTitle: 'DELETE',
                                            color: const Color.fromARGB(
                                                255, 151, 36, 36),
                                            fontSize: 20,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemCount: userRecipeList.length,
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
