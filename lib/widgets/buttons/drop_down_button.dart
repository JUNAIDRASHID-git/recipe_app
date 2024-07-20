import 'package:flutter/material.dart';
import 'package:recipe_app/colors/colors.dart';

DropdownButton dropdownButton(List<String> isveg, String selectedItem,
    void Function(String?)? onChanged) {
  return DropdownButton<String>(
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
      onChanged: onChanged);
}
