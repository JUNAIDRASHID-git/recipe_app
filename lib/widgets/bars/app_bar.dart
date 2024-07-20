import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';

// used in Add user recipe , edit user recipe , Favorite screens
AppBar appBar(String title){
  return AppBar(
        leading: const Text(""),
        backgroundColor: Colors.transparent,
        toolbarHeight: 75,
        title: Padding(
          padding: const EdgeInsets.only(left: 16, top: 10),
          child: Text(
            title,
            style:
                TextStyle(color: fontColor, fontSize: 40, fontFamily: "Oswald"),
          ),
        ),
      );
}