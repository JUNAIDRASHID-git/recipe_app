import 'dart:math';

import 'package:flutter/material.dart';

Padding ingredientBox(List<String>ingredientsList,setState) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: ingredientsList.map((ingredient) {
                  return  Chip(
                backgroundColor:
                    Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(0.1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.5)),
                label: Text(ingredient),
                deleteIcon: const Icon(
                  Icons.close,
                  size: 20,
                ),
                onDeleted: (){
                  setState(() {
                    ingredientsList.remove(ingredient);
                  });
                },
              );
                }).toList()),
          );
  }