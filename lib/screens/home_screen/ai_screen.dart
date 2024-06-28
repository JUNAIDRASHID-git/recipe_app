import 'package:flutter/material.dart';

class AIScreen extends StatelessWidget {
  const AIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(180, 75, 75, 75),
      extendBody: true,
      body: Center(
        child: Text("Generate Recipe",style: TextStyle(fontSize: 40,color: Colors.white),),
      ),
    );
  }
}