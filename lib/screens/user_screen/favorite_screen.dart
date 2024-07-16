import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';
import 'package:recipe_app/db/functions/db_functions/userfunctions.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/screens/home_screen/recipe_details_screen.dart';
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
      appBar: AppBar(
        leading: const Text(""),
        backgroundColor: Colors.transparent,
        toolbarHeight: 75,
        title: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Text(
            "Favorite Recipes",
            style:
                TextStyle(color: fontColor, fontSize: 40, fontFamily: "Oswald"),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: userFavRecipeNotifier,
        builder: (context, value, child) {
          return value.isEmpty? Center(
            child: Text("No Favorite Recipes Data",style: TextStyle(color: fontColor,fontSize: 20),),
          ):
          
           Padding(
             padding: const EdgeInsets.only(top: 20),
             child: ListView.separated(
              itemBuilder: (context, index) {
                final data = value[index];
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
                        borderRadius: const BorderRadius.all(Radius.circular(40)),
                      ),
                      width: 80,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        color: isLiked ? fontColor : favoriteColor,
                                      );
                                    },
                                    onTap: (bool isLiked) async {
                                      bool fav = false;
                                      
                                      showDialog(context: context, builder: (context) {
                                        return DialogMessageWidget(yesAction: (){
                                            setState(() {
                                        deleteUserFavRecipe(widget.userdetails.id, index);
                                      });
                                      Navigator.pop(context);
                                        }, messageText: "Do you Want to Remove Recipe");
                                      },);
                                      
                                      return fav;
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
              itemCount: value.length,
                       ),
           );
        },
      ),
    );
  }
}
