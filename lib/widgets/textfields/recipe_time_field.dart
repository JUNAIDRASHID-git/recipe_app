import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/textfields/addrecipe_textfield.dart';

SizedBox timeFormField({required TextEditingController timeController}){
  return SizedBox(
                        height: 65,
                        width: 153,
                        child: TextFieldAddRecipe(
                          keyboardType: TextInputType.number,
                          controller: timeController,
                          label: 'Time',
                          prefixIcon: const Icon(Icons.edit),
                        ),
                      );
}