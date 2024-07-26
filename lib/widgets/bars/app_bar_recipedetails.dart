import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/db/models/recipedb.dart';

AppBar appBarRecipeDetailsScreen(Recipe recipedetails) {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: fontColor, size: 30),
      toolbarHeight: 80,
      title: Center(
        child: Text(recipedetails.title,style: TextStyle(color: fontColor, fontSize: 40),
      )),
      actions: [
        IconButton(
            onPressed: () {log("share button pressed");},
            icon: const Icon(Icons.share))
      ],
    );
  }