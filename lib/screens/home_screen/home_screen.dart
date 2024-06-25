import 'package:flutter/material.dart';
import 'package:recipe_app/db/dbfunctions/recipe_functions.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/screens/home_screen/home_drawer.dart';
import 'package:recipe_app/screens/home_screen/list_recipe_widget.dart';
import 'package:recipe_app/textfields/textfield.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.userdetails});
  final User userdetails;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _searchRecipeController = TextEditingController();

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
          padding: const EdgeInsets.only(left: 20),
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
        toolbarHeight: 60,
        title: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Recipe Heaven",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(180, 75, 75, 75),
      body: SafeArea(
          child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFieldMain(
                  icon: const Icon(
                    Icons.search,
                    size: 25,
                  ),
                  prefixText: "Search Recipes",
                  obscuretext: false,
                  controller: _searchRecipeController),
            ),
            const SizedBox(
              height: 20,
            ),
            const Expanded(child: ListRecipe()),
          ],
        ),
      )),
    );
  }
}
