import 'package:flutter/material.dart';

class TextFieldMain extends StatelessWidget {
  final Widget icon;
  final String prefixText;
  final bool obscuretext;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const TextFieldMain(
      {super.key,
      required this.icon,
      required this.prefixText,
      required this.obscuretext,
      required this.controller,required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscuretext,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: icon,
        hintText: prefixText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        fillColor: const Color.fromARGB(234, 255, 255, 255),
        filled: true,
      ),
    );
  }
}
