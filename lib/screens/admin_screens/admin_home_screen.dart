import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe_app/buttons/mainbutton.dart';
import 'package:recipe_app/screens/admin_screens/recipe_screens_admin/admin_recipe_screen.dart';
import 'package:recipe_app/screens/user_screen/login_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(180, 75, 75, 75),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            "ADMIN",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                MainButton(
                    buttonTitle: "RECIPES",
                    buttonAction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminRecipeScreen()));
                    }),
                MainButton(buttonTitle: "USERS", buttonAction: () {}),
              ],
            ),
            MainButton(
                buttonTitle: "Back to Login",
                buttonAction: () {
                  log("back to login clicked");
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                }),
          ],
        ),
      ),
    );
  }
}
