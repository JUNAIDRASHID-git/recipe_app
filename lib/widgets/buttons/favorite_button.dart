import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/db/functions/db_functions/userfunctions.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/db/models/userdb.dart';

LikeButton favButton({required Recipe data,required List<Recipe> favorite,required User userData}) {
    return LikeButton(
                                    size: 55,
                                    bubblesSize: 90,
                                    bubblesColor: BubblesColor(
                                        dotPrimaryColor: favoriteColor,
                                        dotSecondaryColor: favoriteColor),
                                    likeBuilder: (bool isLiked) {
                                      return Icon(
                                        Icons.star_rounded,
                                        size: 55,
                                        color: data.fav ? favoriteColor : fontColor,
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
                                        email: userData.email,
                                        username: userData.username,
                                        password: userData.password,
                                        id: userData.id,
                                        favorite: favorite,
                                      );

                                      addUserRecipe(id:userData.id, value: updatedUser);
                                      getUserFav(id:userData.id);
                                      log(isLiked ? "Disliked" : "Liked");

                                      return !isLiked;
                                    },
                                  );
  }