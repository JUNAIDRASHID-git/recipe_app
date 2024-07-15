import 'package:flutter/material.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';

class TextFieldAddRecipe extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const TextFieldAddRecipe({
    super.key,
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
  });

  @override
  State<TextFieldAddRecipe> createState() => _TextFieldAddRecipeState();
}

class _TextFieldAddRecipeState extends State<TextFieldAddRecipe> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      style: TextStyle(color: fontColor, fontSize: 20),
      maxLines: 100,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        fillColor: Colors.grey,
        filled: true,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        label: Text(widget.label),
        labelStyle: TextStyle(
            color: fontColor, fontSize: 30, fontWeight: FontWeight.bold),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
      ),
      controller: widget.controller,
      validator: widget.validator,
    );
  }
}
