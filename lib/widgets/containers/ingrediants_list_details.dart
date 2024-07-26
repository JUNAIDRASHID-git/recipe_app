import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';
import 'package:recipe_app/db/models/recipedb.dart';

ListView listIngrediansDetailsWidget(Recipe recipedetails,BuildContext context) {
    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recipedetails.ingrediants.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.circle,size: 10,),
                          iconColor: fontColor,
                          title: Text(recipedetails.ingrediants[index].toUpperCase(),style: TextStyle(color: fontColor,fontSize: 20),),
                        );
                      },separatorBuilder: (BuildContext context, int index) { 
                        return const SizedBox(height: 1);
                       },
                    );
  }