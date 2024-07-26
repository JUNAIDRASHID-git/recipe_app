import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/db/functions/db_functions/recipe_functions.dart';
import 'package:recipe_app/db/functions/db_functions/userfunctions.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/db/models/userdb.dart';

LikeButton favButton(
    {required Recipe data,
    required List<Recipe> favorite,
    required User userData}) {
  return LikeButton(
    size: 55,
    bubblesSize: 90,
    bubblesColor: BubblesColor(
        dotPrimaryColor: favoriteColor, dotSecondaryColor: favoriteColor),
    likeBuilder: (bool isLiked) {
      return Icon(
        Icons.star_rounded,
        size: 55,
        color: data.fav ? favoriteColor : fontColor,
      );
    },
    onTap: (bool isLiked) async {
      bool currentFav = data.fav;
      final recipe = Recipe(
        image: data.image,
        title: data.title,
        time: data.time,
        description: data.description,
        ingrediants: data.ingrediants,
        instruction: data.instruction,
        id: data.id,
        veg: data.veg,
        fav: !currentFav,
      );

      if (!currentFav) {
        favorite.add(recipe);
      } else if(currentFav){
        favorite.removeWhere((recipe) => recipe.id == data.id);
      }

      final updatedUser = User(
        email: userData.email,
        username: userData.username,
        password: userData.password,
        id: userData.id,
        favorite: favorite,
      );

      updateRecipe(recipe, data.id);
      addUserRecipe(id: userData.id, value: updatedUser);
      getUserFav(id: userData.id);

      return !isLiked;
    },
  );
}
