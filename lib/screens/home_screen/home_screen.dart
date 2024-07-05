import 'package:flutter/material.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';
import 'package:recipe_app/db/dbfunctions/recipe_functions.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/screens/home_screen/home_drawer.dart';
import 'package:recipe_app/screens/home_screen/list_recipe_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.userdetails});
  final User userdetails;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getAllRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: HomeDrawer(userdetails: widget.userdetails),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20,top: 10),
          child: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu)),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 40,
        ),
        backgroundColor: Colors.transparent,
        toolbarHeight: 75,
        title:  Padding(
          padding: const EdgeInsets.only(left: 35,top: 10),
          child: Text(
            "Recipe Heaven",
            style: TextStyle(
              fontSize: 40,
              color: fontColor,
              fontWeight: FontWeight.w700,
              fontFamily: "Oswald"
            ),
          ),
        ),
      ),
      
      body: SafeArea(
          child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const ListRecipe(),
      )),
    );
  }
}
