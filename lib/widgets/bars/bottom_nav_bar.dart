import 'package:flutter/material.dart';
import 'package:recipe_app/db/functions/db_functions/userfunctions.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/screens/home_screen/ai_screen.dart';
import 'package:recipe_app/screens/user_screen/favorite_screen.dart';
import 'package:recipe_app/screens/home_screen/home_screen.dart';
import 'package:recipe_app/screens/user_screen/user_recipe_add_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.userdetails});
  final User userdetails;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    getUser(id: widget.userdetails.id);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      Home(userdetails: widget.userdetails),
      FavoriteScreen(userdetails: widget.userdetails),
      UserRecipeAddScreen(userdetails: widget.userdetails),
      const AIScreen(),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, currentIndex, _) {
          return children[currentIndex];
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, currentIndex, _) {
          return SalomonBottomBar(
            backgroundColor: Colors.grey,
            currentIndex: currentIndex,
            onTap: (index) {
              _currentIndex.value = index;
            },
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.favorite),
                title: const Text("Favorite"),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.notes),
                title: const Text("Add Recipe"),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.stream),
                title: const Text("AI Chef"),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }
}
