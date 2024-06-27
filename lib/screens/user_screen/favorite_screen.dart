import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(180, 75, 75, 75),
      extendBody: true,
      body: Center(
        child: Text("Favorite screen",style: TextStyle(fontSize: 40,color: Colors.white),),
      ),
    );
  }
}
