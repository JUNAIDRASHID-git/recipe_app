import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:recipe_app/bottombar/bottom_nav_bar.dart';
import 'package:recipe_app/buttons/mainbutton.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/screens/admin_screens/admin_home_screen.dart';
import 'package:recipe_app/screens/user_screen/signup_screen.dart';
import 'package:recipe_app/textfields/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late Box userDB;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userDB = Hive.box<User>("user_db");
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
                    "Welcome",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  Text(
                    "Back",
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
                      " Login",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldMain(
                        icon: const Icon(Icons.person),
                        prefixText: "UserName",
                        obscuretext: false,
                        controller: _usernameController,
                        validator: (value) {
                          final nameRegex = RegExp(r'^[a-zA-Z]{3,20}$');
                          if (value == null || value.isEmpty) {
                            return 'Please Enter The Name';
                          } else if (!nameRegex.hasMatch(value)) {
                            return "Name Must be a Charactor";
                          } else if (value.length < 4) {
                            return 'Please Enter Name Grater Than 4 Charator';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldMain(
                        icon: const Icon(Icons.lock),
                        prefixText: "Password",
                        obscuretext: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter The Password";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        log("create account pressed");
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()),
                            (route) => false);
                      },
                      child: const Text(
                        "  Create an Account",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: MainButton(
                buttonTitle: "Login",
                buttonAction: () {
                  log("Login pressed");
                  if (_formKey.currentState!.validate()) {
                    login();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login() {
    String admin = "admin";
    String adminPass = "admin123";
    for (var element in userDB.values) {
      if (element.username == _usernameController.text &&
          element.password == _passwordController.text) {
        log("user ${element.username} successfuly loged in");
        log("user ${element.password} successfuly loged in");
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BottomNavBar(
            userdetails: element,
          ),
        ));
        break;
      } else if (admin == _usernameController.text &&
          adminPass == _passwordController.text) {
        log("admin loged in");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const AdminScreen()),
            (route) => false);
        break;
      } else {
        log("Invalid password");
        const snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text("! Please Enter Correct userName And Password"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        break;
      }
    }
  }
}
