import 'package:flutter/material.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';
import 'package:recipe_app/widgets/buttons/edit_delete_button.dart';
import 'package:recipe_app/db/functions/db_functions/recipe_functions.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/screens/admin_screens/recipe_screens_admin/recipe_edit_screen.dart';
import 'package:recipe_app/screens/home_screen/recipe_details_screen.dart';
import 'package:recipe_app/widgets/containers/image_widget_container.dart';
import 'package:recipe_app/widgets/containers/time_widget_container.dart';
import 'package:recipe_app/widgets/containers/veg_widget_container.dart';
import 'package:recipe_app/widgets/dialog_widgets/dialog_message_widget.dart';
import 'package:recipe_app/widgets/text_widgets/recipe_description_widget.dart';
import 'package:recipe_app/widgets/text_widgets/recipe_title_widget.dart';

class RecipeListAdmin extends StatefulWidget {
  const RecipeListAdmin({super.key});

  @override
  State<RecipeListAdmin> createState() => _RecipeListAdminState();
}

class _RecipeListAdminState extends State<RecipeListAdmin> {
  final TextEditingController _searchController = TextEditingController();
  List<Recipe> filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterRecipes);
  }

  void _filterRecipes() {
    setState(() {
      filteredRecipes = recipeNotifier.value
          .where((recipe) => recipe.title
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: recipeNotifier,
      builder: (BuildContext context, List<Recipe> recipeList, Widget? child) {
        filteredRecipes = filteredRecipes.isEmpty && _searchController.text.isEmpty ? recipeList: filteredRecipes;
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  isDense: true,
                  fillColor: Color.fromARGB(255, 245, 245, 245),
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  hintText: 'Search Recipes...',
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            filteredRecipes.isNotEmpty ? Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final data = filteredRecipes[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RecipeDetailScreen(
                            recipedetails: data,
                          ),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: recipeContainerColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40))),
                        width: 80,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              RecipeTileWidget(data: data),
                              ImageWidgetContainer(data: data),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        VegWidgetContainer(data: data),
                                        TimeWidgetContainer(data: data)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    child: RecipeDescriptionWidget(data: data)
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  DeleteEditButton(
                                      buttonAction: () {
                                        Navigator.push(context,MaterialPageRoute(builder: (context) =>UpdateRecipeadmin(recipeData: data)));
                                      },
                                      buttonTitle: "EDIT",
                                      color:const Color.fromARGB(255, 62, 62, 62),
                                      fontSize: 20),
                                  DeleteEditButton(
                                      buttonAction: () {
                                        showDialog(
                                        context: context,
                                        builder: (context) {
                                         return DialogMessageWidget(
                                           
                                            yesAction: () {  
                                              deleteRecipe(data.id);
                                              Navigator.pop(context);
                                            }, 
                                            messageText: 'Do You Want to delete ${data.title}',);
                                          },
                                        );
                                      },
                                      buttonTitle: "DELETE",
                                      color: const Color.fromARGB( 255, 180, 67, 59),
                                      fontSize: 20),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: filteredRecipes.length,
              ),
            ) :  Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Text("No Data Found",style: TextStyle(color: fontColor,fontSize: 30),),
            )
          ],
        );
      },
    );
  }
}
