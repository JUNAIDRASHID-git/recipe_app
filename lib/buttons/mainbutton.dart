import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String buttonTitle;
  final void Function() buttonAction;
  const MainButton({super.key,required this.buttonTitle, required this.buttonAction});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: buttonAction,
      child: Padding(
                padding:  const EdgeInsets.only(bottom: 20),
                child: Container(
                  height: 75,
                  width: 330,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.black54
                  ),
                  child:  Center(
                    child: Text(buttonTitle,style: const TextStyle(color: Colors.white,fontSize: 30),),
                  ),
                ),
              ),
    );
  }
}