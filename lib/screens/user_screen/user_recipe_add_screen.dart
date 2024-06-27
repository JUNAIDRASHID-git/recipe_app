import 'package:flutter/material.dart';

class UserRecipeAddScreen extends StatelessWidget {
  const UserRecipeAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(180, 75, 75, 75),
      body: Center(
        child: Text("Recipe Add Screen",style: TextStyle(fontSize: 40,color: Colors.white),),
      ),
    );
  }
}
