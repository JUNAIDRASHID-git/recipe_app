import 'package:flutter/material.dart';

class DeleteEditButton extends StatelessWidget {
  final Function() buttonAction;
  final String buttonTitle;
  final Color color;
  final double fontSize;
  const DeleteEditButton(
      {super.key,
      required this.buttonAction,
      required this.buttonTitle,
      required this.color,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonAction,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          height: 65,
          width: 320,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: color,
          ),
          child: Center(
            child: Text(
              buttonTitle,
              style: TextStyle(color: Colors.white, fontSize: fontSize),
            ),
          ),
        ),
      ),
    );
  }
}
