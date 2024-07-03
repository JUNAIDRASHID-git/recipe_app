import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/buttons/mainbutton.dart';
import 'package:recipe_app/screens/user_screen/login_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(180, 75, 75, 75),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Make",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  Text(
                    "Your Magical Food",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
            ),
            const Center(
              child: Image(image: AssetImage("assets/logos/Into_Logo.png")),
            ),
            MainButton(
              buttonTitle: "START",
              buttonAction: () {
                log("Start pressed");
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
