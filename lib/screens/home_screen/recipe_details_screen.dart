import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';
import 'package:recipe_app/db/dbfunctions/recipe_functions.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/widgets/containers/time_widget_container.dart';
import 'package:recipe_app/widgets/containers/veg_widget_container.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipedetails;

  const RecipeDetailScreen({
    super.key,
    required this.recipedetails,
  });

  @override
  Widget build(BuildContext context) {
    getAllRecipes();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        toolbarHeight: 80,
        title: Center(
            child: Text(
          recipedetails.title,
          style:  TextStyle(color: fontColor, fontSize: 40),
        )),
        actions: [
          IconButton(
              onPressed: () {
                log("share button pressed");
              },
              icon: const Icon(Icons.share))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Fav Button
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.star_rounded,
                    size: 55,
                    color: recipedetails.fav == true
                        ? Colors.yellow
                        : Colors.white,
                  )),
            ],
          ),
          SizedBox(
            height: 250,
            child: Image.file(File(recipedetails.image)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VegWidgetContainer(data: recipedetails),
                    TimeWidgetContainer(data: recipedetails)
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipedetails.description,
                      style:  TextStyle(color: fontColor, fontSize: 17),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                     Text(
                      "Incrediance :",
                      style: TextStyle(color: fontColor, fontSize: 25),
                    ),
                    Text(
                      recipedetails.ingrediants,
                      style:  TextStyle(color: fontColor),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                     Text(
                      "Instructions :",
                      style: TextStyle(color: fontColor, fontSize: 25),
                    ),
                    Text(
                      recipedetails.instruction,
                      style:  TextStyle(color: fontColor),
                    )
                  ],
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
