import 'package:flutter/material.dart';

class TextFieldAddRecipe extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Widget prefixIcon;
  const TextFieldAddRecipe(
      {super.key, required this.controller, required this.label, required this.prefixIcon});

  @override
  State<TextFieldAddRecipe> createState() => _TextFieldAddRecipeState();
}

class _TextFieldAddRecipeState extends State<TextFieldAddRecipe> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.grey,
        filled: true,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        label: Text(widget.label),
        labelStyle: const TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
            prefixIcon: widget.prefixIcon,
      ),
      controller: widget.controller,
    );
  }
}
