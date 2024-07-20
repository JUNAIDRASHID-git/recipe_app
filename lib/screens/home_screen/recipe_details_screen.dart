import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/db/models/recipedb.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/widgets/buttons/favorite_button.dart';
import 'package:recipe_app/widgets/containers/time_widget_container.dart';
import 'package:recipe_app/widgets/containers/veg_widget_container.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipedetails;
  final User? userdetails;
 final List<Recipe>? favorite;
  const RecipeDetailScreen({super.key,required this.recipedetails, this.userdetails,this.favorite});
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.end,
             children: [
               favButton(data: recipedetails, favorite: favorite!, userData: userdetails!),
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
                      TimeWidgetContainer(data: recipedetails),
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
                        style: TextStyle(color: fontColor, fontSize:20),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Ingredients:",
                        style: TextStyle(color: fontColor, fontSize: 25),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: recipedetails.ingrediants.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.circle,size: 10,),
                            iconColor: fontColor,
                            title: Text(recipedetails.ingrediants[index].toUpperCase(),style: TextStyle(color: fontColor,fontSize: 20),),
                          );
                        }, separatorBuilder: (BuildContext context, int index) { 
                          return const SizedBox(height: 1,);
                         },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Instructions:",
                        style: TextStyle(color: fontColor, fontSize: 25),
                      ),
                      Text(
                        recipedetails.instruction,
                        style: TextStyle(color: fontColor,fontSize: 20),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
