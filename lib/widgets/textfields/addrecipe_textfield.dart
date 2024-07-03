import 'package:flutter/material.dart';

class TextFieldAddRecipe extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Widget prefixIcon;
  final TextInputType? keyboardType;
  const TextFieldAddRecipe(
      {super.key,
      required this.controller,
      required this.label,
      required this.prefixIcon,
      this.keyboardType,
      });

  @override
  State<TextFieldAddRecipe> createState() => _TextFieldAddRecipeState();
}

class _TextFieldAddRecipeState extends State<TextFieldAddRecipe> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      style: const TextStyle(color: Colors.white, fontSize: 20),
      maxLines: 100,
      keyboardType: widget.keyboardType,
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
