import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';

Padding searchTextField(TextEditingController? searchController) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                isDense: true,
                fillColor: fontColor,
                filled: true,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                hintText: 'Search Recipes...',
              ),
            ),
          );
  }