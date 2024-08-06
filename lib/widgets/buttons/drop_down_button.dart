import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';

Container dropdownButton(List<String> isveg, String selectedItem,
    void Function(String?)? onChanged) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: textFormFieldColor,
      border: Border.all(),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5),
      child: DropdownButton<String>(
          underline: const SizedBox.shrink(),
          style: TextStyle(
              color: fontColor, fontSize: 15, fontWeight: FontWeight.bold),
          dropdownColor: textFormFieldColor,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          value: selectedItem,
          items: isveg.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged),
    ),
  );
}
