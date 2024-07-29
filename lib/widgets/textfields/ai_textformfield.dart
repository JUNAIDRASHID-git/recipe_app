  import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';

Padding aiTextFormField(void Function()? onPressed,ingredientsController) {
    return Padding(
            padding: const EdgeInsets.only(
                bottom: 10, top: 10, left: 10, right: 10),
            child: SizedBox(
              height: 69,
              child: TextFormField(
                controller: ingredientsController,
                style: TextStyle(color: fontColor, fontSize: 20),
                decoration: InputDecoration(
                  fillColor: textFormFieldColor,
                  filled: true,
                  prefixIcon: const Text(""),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: onPressed,
                      icon: CircleAvatar(
                        backgroundColor: floatActionButtonColor,
                        child: Text(
                          "Add",
                          style: TextStyle(color: fontColor),
                        ),
                      ),
                    ),
                  ),
                  labelText: "Enter Ingredients",
                  labelStyle: TextStyle(
                      color: fontColor,
                      fontSize: 20,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          );
  }