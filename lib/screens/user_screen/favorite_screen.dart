import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/db/functions/db_functions/recipe_functions.dart';
import 'package:recipe_app/db/functions/db_functions/userfunctions.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/screens/user_screen/fav_recipe_details.dart';
import 'package:recipe_app/widgets/bars/app_bar.dart';
import 'package:recipe_app/widgets/containers/image_widget_container.dart';
import 'package:recipe_app/widgets/containers/time_widget_container.dart';
import 'package:recipe_app/widgets/containers/veg_widget_container.dart';
import 'package:recipe_app/widgets/dialog_widgets/dialog_message_widget.dart';
import 'package:recipe_app/widgets/text_widgets/recipe_description_widget.dart';
import 'package:recipe_app/widgets/text_widgets/recipe_title_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key, required this.userdetails});
  final User userdetails;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    getUserFav(id: widget.userdetails.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: mainbgcolor,
      appBar: appBar('Favorite Recipes'),
      body: ValueListenableBuilder(
        valueListenable: userFavRecipeNotifier,
        builder: (context, value, child) {
          return value.isEmpty
              ? Center(
                  child: Text("No Favorite Recipes Added",
                      style: TextStyle(color: fontColor, fontSize: 20)),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        final data = value[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FavRecipeDetailScreen(
                                      recipedetails: data)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: recipeContainerColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                              ),
                              width: 80,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RecipeTileWidget(data: data),
                                          LikeButton(
                                            size: 55,
                                            bubblesSize: 90,
                                            bubblesColor: BubblesColor(
                                                dotPrimaryColor: favoriteColor,
                                                dotSecondaryColor:
                                                    favoriteColor),
                                            likeBuilder: (bool isLiked) {
                                              return Icon(
                                                Icons.star_rounded,
                                                size: 55,
                                                color: isLiked
                                                    ? fontColor
                                                    : favoriteColor,
                                              );
                                            },
                                            onTap: (bool isLiked) async {
                                              bool fav = false;
                                            final recipe =  Recipe(
                                                  image: data.image,
                                                  title: data.title,
                                                  time: data.time,
                                                  description: data.description,
                                                  ingrediants: data.ingrediants,
                                                  instruction: data.instruction,
                                                  id: data.id,
                                                  veg: data.veg,
                                                  fav: false);

                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return DialogMessageWidget(
                                                      yesAction: () {
                                                        setState(() {
                                                          deleteUserFavRecipe(
                                                              widget.userdetails
                                                                  .id,
                                                              index);
                                                        });
                                                        updateRecipe(recipe, data.id);
                                                        Navigator.pop(context);
                                                      },
                                                      messageText:
                                                          "Do you Want to Remove Recipe");
                                                },
                                              );

                                              return fav;
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    ImageWidgetContainer(data: data),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 5),
                                            child: RecipeDescriptionWidget(
                                                data: data)),
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
                      itemCount: value.length),
                );
        },
      ),
    );
  }
}
