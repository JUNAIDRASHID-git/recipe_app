import 'package:flutter/material.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainbgcolor,
      extendBody: true,
      body: const Center(
        child: Text(
          "Favorite screen",
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
      ),
    );
  }
}
