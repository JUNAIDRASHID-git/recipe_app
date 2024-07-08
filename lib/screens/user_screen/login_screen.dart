import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/db/models/userdb.dart';
import 'package:recipe_app/screens/admin_screens/admin_home_screen.dart';
import 'package:recipe_app/widgets/bottombar/bottom_nav_bar.dart';
import 'package:recipe_app/widgets/buttons/mainbutton.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';
import 'package:recipe_app/screens/user_screen/signup_screen.dart';
import 'package:recipe_app/widgets/textfields/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Box userDB;

  @override
  void initState() {
    super.initState();
    userDB = Hive.box<User>("user_db");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Welcome",
                    style: TextStyle(color: fontColor, fontSize: 40),
                  ),
                  Text(
                    "Back",
                    style: TextStyle(color: fontColor, fontSize: 30),
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
                    Text(
                      " Login",
                      style: TextStyle(color: fontColor, fontSize: 30),
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
                      child: Text(
                        "  Create an Account",
                        style: TextStyle(color: fontColor, fontSize: 15),
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

    String userName = _usernameController.text;
    String password = _passwordController.text;

    bool found = false;

    for (var element in userDB.values) {
      if (element.username == userName && element.password == password) {
        log("user ${element.username} successfully logged in");
        found = true;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BottomNavBar(
            userdetails: element,
          ),
        ));
        break;
      }
    }

    if (!found) {
      if (admin == userName && adminPass == password) {
        log("admin logged in");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const AdminScreen()),
            (route) => false);
      } else {
        log("Invalid password");
        const snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text("! Please Enter Correct Username And Password"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
