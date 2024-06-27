import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_app/buttons/mainbutton.dart';
import 'package:recipe_app/db/dbfunctions/userfunctions.dart';
import 'package:recipe_app/screens/user_screen/login_screen.dart';
import 'package:recipe_app/textfields/textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(180, 75, 75, 75),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Create",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  Text(
                    "Your Account",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      " REGISTER",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldMain(
                      icon: const Icon(Icons.mail),
                      prefixText: "Email",
                      obscuretext: false,
                      controller: _emailController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldMain(
                      icon: const Icon(Icons.person),
                      prefixText: "UserName",
                      obscuretext: false,
                      controller: _usernameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldMain(
                      icon: const Icon(Icons.lock),
                      prefixText: "Password",
                      obscuretext: true,
                      controller: _passwordController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        log("Already have an Account pressed");
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false);
                      },
                      child: const Text(
                        "   Already have an Account",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: MainButton(
                buttonTitle: "Sign Up",
                buttonAction: () {
                  log("sign up pressed");
                  addUser(
                      email: _emailController.text,
                      username: _usernameController.text,
                      password: _passwordController.text,
                      id: DateTime.now().millisecondsSinceEpoch.toString());
                      log("$_usernameController");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
