import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe_app/db/dbfunctions/recipe_functions.dart';
import 'package:recipe_app/db/models/recipedb.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipedetails;

  const RecipeDetailScreen({
    super.key,
    required this.recipedetails,
  });

  @override
  Widget build(BuildContext context) {
    getAllRecipes();
    final vegcolor = recipedetails.veg != true
        ? Colors.red
        : const Color.fromARGB(255, 51, 118, 53);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        toolbarHeight: 80,
        title: Center(
            child: Text(
          recipedetails.title,
          style: const TextStyle(color: Colors.white, fontSize: 40),
        )),
        actions: [
          IconButton(
              onPressed: () {
                log("share button pressed");
              },
              icon: const Icon(Icons.share))
        ],
      ),
      backgroundColor: const Color.fromARGB(180, 75, 75, 75),
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
            child: Image.asset(recipedetails.image),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: recipedetails.veg == true
                              ? const Color.fromARGB(255, 122, 255, 126)
                              : const Color.fromARGB(255, 255, 212, 19),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40))),
                      child: Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: vegcolor, width: 1.5),
                                    borderRadius: BorderRadius.circular(5)),
                                height: 15,
                                width: 15,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Center(
                                    child: CircleAvatar(
                                      backgroundColor: vegcolor,
                                    ),
                                  ),
                                ),
                              )),
                          recipedetails.veg == true
                              ? const Text(
                                  "Veg  ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              : const Text("Non Veg  ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: recipedetails.time <= 20
                              ? const Color.fromARGB(255, 122, 255, 126)
                              : const Color.fromARGB(255, 255, 212, 19),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40))),
                      width: 70,
                      child: Row(
                        children: [
                          const Icon(Icons.access_time_filled_sharp),
                          Text("${recipedetails.time}min"),
                        ],
                      ),
                    ),
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
                      style: const TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Incrediance :",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Text(
                      recipedetails.ingrediants,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Instructions :",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Text(
                      recipedetails.instruction,
                      style: const TextStyle(color: Colors.white),
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
