import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final Widget icon;
  final String prefixText;
  final bool obscuretext;
  final Function(String)? onChanged;
   const SearchTextField(
      {super.key,
      required this.icon,
      required this.prefixText,
      required this.obscuretext,required this.onChanged, required TextEditingController controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
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
