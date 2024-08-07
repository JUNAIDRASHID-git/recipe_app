import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/db/functions/db_functions/userfunctions.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/screens/user_screen/fav_recipe_details.dart';
import 'package:recipe_app/screens/user_screen/profile_screen.dart';
import 'package:recipe_app/screens/user_screen/user_recipe_edit.dart';
import 'package:recipe_app/widgets/buttons/edit_delete_button.dart';
import 'package:recipe_app/widgets/containers/image_widget_container.dart';
import 'package:recipe_app/widgets/containers/time_widget_container.dart';
import 'package:recipe_app/widgets/containers/veg_widget_container.dart';
import 'package:recipe_app/widgets/dialog_widgets/dialog_message_widget.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        iconTheme: IconThemeData(color: fontColor, size: 35),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(userdetails: widget.userdetails)));
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Padding(
            padding: EdgeInsets.only(left: 45),
            child: ScreenTitleHeading(title: "Saved Recipes")),
      ),
      body: ValueListenableBuilder(
        valueListenable: userRecipeNotifier,
        builder:
            (BuildContext context, List<Recipe> userRecipeList, Widget? child) {
          return userRecipeList.isEmpty
              ? Center(
                  child: Text(
                    "No Recipes are Saved",
                    style: TextStyle(color: fontColor, fontSize: 25),
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(height: 30),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final data = userRecipeList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FavRecipeDetailScreen(recipedetails: data),
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: recipeContainerColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(40)),),
                                width: 80,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 25),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10, left: 10),
                                        child: Row(
                                          mainAxisAlignment:MainAxisAlignment.start,
                                          children: [
                                            RecipeTileWidget(data: data),
                                          ],
                                        ),
                                      ),
                                      ImageWidgetContainer(data: data),
                                      Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserRecipeEditScreen(recipeData: data,userData:widget.userdetails,index: index),
                                                  ),
                                                );
                                              },
                                              buttonTitle: 'EDIT',
                                              color: editButtonColor,
                                              fontSize: 20),
                                          DeleteEditButton(
                                            buttonAction: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return DialogMessageWidget(
                                                      yesAction: () {
                                                        setState(() {
                                                          deleteUserRecipe(widget.userdetails.id,index);
                                                        });
                                                        log("delete pressed");
                                                        Navigator.pop(context);
                                                      },
                                                      messageText:
                                                          "Do you want to Delete?");
                                                },
                                              );
                                            },
                                            buttonTitle: 'DELETE',
                                            color: deleteButtonColor,
                                            fontSize: 20,
                                          ),
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
