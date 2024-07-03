import 'package:flutter/material.dart';

class SidebarButtons extends StatelessWidget {
  const SidebarButtons({super.key, required this.text, required this.action});

  final String text;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(30))
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
              const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
