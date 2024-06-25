import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/screens/favorite_screen.dart';
import 'package:recipe_app/screens/home_screen/home_screen.dart';
import 'package:recipe_app/user_recipe_add_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.userdetails});
  final User userdetails;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

    final List<Widget> children = [
       Home(userdetails: widget.userdetails,),
      const FavoriteScreen(),
      const UserRecipeAddScreen(),
      const UserRecipeAddScreen(),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: ValueListenableBuilder(
        valueListenable: currentIndex,
        builder: (context, currentIndex, _) {
          return children[currentIndex];
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 350),
        buttonBackgroundColor: const Color.fromARGB(255, 101, 101, 101),
        backgroundColor: Colors.transparent,
        color: const Color.fromARGB(255, 101, 101, 101),
        height: 60,
        index: currentIndex.value,
        onTap: (index) {
          currentIndex.value = index;
        },
        items: const <Widget>[
          Icon(Icons.home_filled, size: 30),
          Icon(Icons.favorite, size: 30),
          Icon(Icons.notes, size: 30),
          Icon(Icons.favorite, size: 30),
        ],
      ),
    );
  }
}
